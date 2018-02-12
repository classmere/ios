// swiftlint:disable cyclomatic_complexity function_body_length

import Foundation

enum Emoji: String {
    case YDE = "👶"
    case ALS = "🎒"
    case ACTG = "📠"
    case AHE = "👨"
    case AS = "🚀"
    case AED, AGRI, AG = "🌽"
    case ASL = "✋"
    case ANS = "🐵"
    case ANTH = "👴"
    case AEC = "📉"
    case ARAB = "🕌"
    case ART = "🎨"
    case ASN = "⛩"
    case ATS = "🌤"
    case BB = "🌡"
    case BHS = "😷"
    case bee, bioe = "🔬"
    case BI = "🐨"
    case BRR = "📚"
    case BOT = "🌷"
    case BA = "🏢"
    case CBEE, CHE = "🔬"
    case CH = "⚗"
    case CHN = "🇨🇳"
    case CCE, CE, CEM = "🚧"
    case COMM = "🗣"
    case CS = "💻"
    case CSS, CROP = "🌿"
    case DHE = "🍥"
    case ECON = "📈"
    case ED = "🎓"
    case ECE = "💡"
    case EGNR = "🔨"
    case ENG = "📖"
    case ENT = "🐛"
    case EAH = "🌺"
    case ENVE = "🌲"
    case ENSC = "🌳"
    case ES = "👲🏾"
    case FILM = "📽"
    case FIN = "💰"
    case FW = "🐠"
    case FCSJ = "🍱"
    case FST = "🍴"
    case fes, fe, for = "🌲"
    case FR = "🇫🇷"
    case GS = "🔬"
    case GEOG, GEO = "🗺"
    case GER = "🇩🇪"
    case GRAD = "🎓"
    case GD = "🖊"
    case HHS = "😷"
    case HEBR = "🇮🇱"
    case HST, HSTS = "📚"
    case HC = "🤓"
    case HORT = "🌻"
    case HDFS = "👨‍👩‍👧‍👦"
    case HEST = "👩"
    case IE = "🛠"
    case IEPA, IEPG, IEPH = "📖"
    case INTL = "🌎"
    case IT = "🇮🇹"
    case JPN = "🇯🇵"
    case KIN = "🏃"
    case LEAD = "👸"
    case LA, LS = "🙆"
    case LIB = "📘"
    case LING = "🖊"
    case MGMT = "👔"
    case MFGE = "🛠"
    case MRKT = "💶"
    case MATS = "💎"
    case MTH = "📊"
    case MIME = "⚒"
    case ME = "⚙"
    case MB = "🐤"
    case MS = "💣"
    case MUS, MUP, MUED = "🎵"
    case NR = "💨"
    case NS = "⚓️"
    case NMC = "📱"
    case NSE = "💡"
    case NUTR = "🍎"
    case OC = "🌊"
    case PAX = "☮️"
    case PHAR = "💊"
    case PHL = "🤔"
    case PAC = "⛹"
    case PH = "💫"
    case PBG = "🌱"
    case PS = "🏛"
    case PSY = "🙇"
    case H = "🤒"
    case PPOL = "⚖"
    case QS = "👬"
    case RNG = "🏞"
    case REL = "🕍"
    case ROB = "🤖"
    case RS = "🏡"
    case RUS = "🇷🇺"
    case SED = "📊"
    case SOC = "👨‍👩‍👧‍👦"
    case SOIL = "💩"
    case SPAN = "🇪🇸"
    case ST = "📊"
    case SUS = "🌦"
    case TA = "🎭"
    case TOX = "😵"
    case TCS = "🏙"
    case UEXP = "🎒"
    case VMB = "🐶"
    case WGSS = "👩‍👩‍👧"
    case WSE = "🌲"
    case WLC = "🌍"
    case WR = "📝"
    case Z = "🐼"
}

    /**
     A model representation of an emoji factory.
     */
    struct EmojiFactory {

        /**
         Returns emoji for a course type
         - Parameter type: Type of a course
         - Returns: An emoji string
         */
        static func emojiFromCourseType(_ type: String?) -> String {
            if let courseType = type {
                switch courseType {
                }
            }

            return "🏫"
        }

        /**
         Returns emoji for a section type
    
         - Parameter type: Type of a section
         - Returns: An emoji string
         */
        static func emojiFromSectionType(_ type: String?) -> String {
            if let sectionType = type {
                switch sectionType {
                case "Lecture":
                    return "🗣"
                case "Laboratory":
                    return "🔬"
                case "Recitation":
                    return "✏️"
                default:
                    return "📓"
                }
            }

            return "📓"
        }

        static func emojiFromSectionProperty(_ property: String) -> String {
            switch property {
            case "Days":
                return "☀️"
            case "Instructor":
                return "👤"
            case "Location":
                return "🗺"
            case "Type":
                return "📝"
            case "Enrolled":
                return "👨‍👩‍👧‍👦"
            case "Dates":
                return "🗓"
            case "CRN":
                return "#️⃣"
            default:
                return "🏫"
            }
        }
    }
