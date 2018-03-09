import Foundation
import SystemConfiguration

func callback(reachability: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) {
    guard let info = info else { return }

    let reachability = Unmanaged<Reachability>.fromOpaque(info).takeUnretainedValue()
    reachability.reachabilityChanged()
}

enum Connection {
    case none
    case wifi
    case cellular
}

extension Connection: CustomStringConvertible {
    var description: String {
        switch self {
        case .none: return "No Connection"
        case .wifi: return "WiFi"
        case .cellular: return "Cellular"
        }
    }

}

final class Reachability {

    private(set) var flags: SCNetworkReachabilityFlags?
    var connection: Connection {
        guard let flags = flags else { return .none }
        if flags.contains(.reachable) && flags.contains(.isWWAN) {
            return .cellular
        } else if flags.contains(.reachable) {
            return .wifi
        } else {
            return .none
        }
    }

    private let reachabilityRef: SCNetworkReachability
    private let reachabilitySerialQueue = DispatchQueue(label: "reachability")

    var onConnectionChange: ((Connection) -> Void)? {
        didSet {
            onConnectionChange != nil ? startNotifying() : stopNotifying()
        }
    }

    required init?() {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)
        guard let ref = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress) else { return nil }
        reachabilityRef = ref
    }

    private func startNotifying() {
        var context = SCNetworkReachabilityContext(version: 0,
                                                   info: nil,
                                                   retain: nil,
                                                   release: nil,
                                                   copyDescription: nil)
        context.info = UnsafeMutableRawPointer(Unmanaged<Reachability>.passUnretained(self).toOpaque())
        print("started notifying")
        if !SCNetworkReachabilitySetCallback(reachabilityRef, callback, &context) {
            stopNotifying()
        }

        if !SCNetworkReachabilitySetDispatchQueue(reachabilityRef, reachabilitySerialQueue) {
            stopNotifying()
        }

        // Perform an initial check
        reachabilitySerialQueue.async {
            self.reachabilityChanged()
        }}

    private func stopNotifying() {
        print("stopped notifying")
        SCNetworkReachabilitySetCallback(reachabilityRef, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachabilityRef, nil)
    }

    fileprivate func reachabilityChanged() {
        var flags = SCNetworkReachabilityFlags()
        if SCNetworkReachabilityGetFlags(reachabilityRef, &flags) {
            self.flags = flags
            onConnectionChange?(connection)
        }
    }

}
