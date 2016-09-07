//
//  EmojiFactory.swift
//  Classmere
//
//  Created by Brandon Lee on 8/30/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
 A model representation of an emoji factory.
 */
struct EmojiFactory {
    
    /**
     Returns emoji for a course type
     - Parameter type: Type of a course
     - Returns: An emoji string
     */
    static func emojiFromCourseType(type: String?) -> String {
        if let courseType = type {
            switch courseType {
            case "YDE":
                return "👶"
            case "ALS":
                return "🎒"
            case "ACTG":
                return "📠"
            case "AHE":
                return "👨"
            case "AS":
                return "🚀"
            case "AED", "AGRI", "AG":
                return "🌽"
            case "ASL":
                return "✋"
            case "ANS":
                return "🐵"
            case "ANTH":
                return "👴"
            case "AEC":
                return "📉"
            case "ARAB":
                return "🕌"
            case "ART":
                return "🎨"
            case "ASN":
                return "⛩"
            case "ATS":
                return "🌤"
            case "BB":
                return "🌡"
            case "BHS":
                return "😷"
            case "BEE", "BIOE":
                return "🔬"
            case "BI":
                return "🐨"
            case "BRR":
                return "📚"
            case "BOT":
                return "🌷"
            case "BA":
                return "🏢"
            case "CBEE", "CHE":
                return "🔬"
            case "CH":
                return "⚗"
            case "CHN":
                return "🇨🇳"
            case "CCE", "CE", "CEM":
                return "🚧"
            case "COMM":
                return "🗣"
            case "CS":
                return "💻"
            case "CSS", "CROP":
                return "🌿"
            case "DHE":
                return "🍥"
            case "ECON":
                return "📈"
            case "ED":
                return "🎓"
            case "ECE":
                return "💡"
            case "EGNR":
                return "🔨"
            case "ENG":
                return "📖"
            case "ENT":
                return "🐛"
            case "EAH":
                return "🌺"
            case "ENVE":
                return "🌲"
            case "ENSC":
                return "🌳"
            case "ES":
                return "👲🏾"
            case "FILM":
                return "📽"
            case "FIN":
                return "💰"
            case "FW":
                return "🐠"
            case "FCSJ":
                return "🍱"
            case "FST":
                return "🍴"
            case "FES", "FE", "FOR":
                return "🌲"
            case "FR":
                return "🇫🇷"
            case "GS":
                return "🔬"
            case "GEOG", "GEO":
                return "🗺"
            case "GER":
                return "🇩🇪"
            case "GRAD":
                return "🎓"
            case "GD":
                return "🖊"
            case "HHS":
                return "😷"
            case "HEBR":
                return "🇮🇱"
            case "HST", "HSTS":
                return "📚"
            case "HC":
                return "🤓"
            case "HORT":
                return "🌻"
            case "HDFS":
                return "👨‍👩‍👧‍👦"
            case "HEST":
                return "👩"
            case "IE":
                return "🛠"
            case "IEPA", "IEPG", "IEPH":
                return "📖"
            case "INTL":
                return "🌎"
            case "IT":
                return "🇮🇹"
            case "JPN":
                return "🇯🇵"
            case "KIN":
                return "🏃"
            case "LEAD":
                return "👸"
            case "LA", "LS":
                return "🙆"
            case "LIB":
                return "📘"
            case "LING":
                return "🖊"
            case "MGMT":
                return "👔"
            case "MFGE":
                return "🛠"
            case "MRKT":
                return "💶"
            case "MATS":
                return "💎"
            case "MTH":
                return "📊"
            case "MIME":
                return "⚒"
            case "ME":
                return "⚙"
            case "MB":
                return "🐤"
            case "MS":
                return "💣"
            case "MUS", "MUP", "MUED":
                return "🎵"
            case "NR":
                return "💨"
            case "NS":
                return "⚓️"
            case "NMC":
                return "📱"
            case "NSE":
                return "💡"
            case "NUTR":
                return "🍎"
            case "OC":
                return "🌊"
            case "PAX":
                return "☮️"
            case "PHAR":
                return "💊"
            case "PHL":
                return "🤔"
            case "PAC":
                return "⛹"
            case "PH":
                return "💫"
            case "PBG":
                return "🌱"
            case "PS":
                return "🏛"
            case "PSY":
                return "🙇"
            case "H":
                return "🤒"
            case "PPOL":
                return "⚖"
            case "QS":
                return "👬"
            case "RNG":
                return "🏞"
            case "REL":
                return "🕍"
            case "ROB":
                return "🤖"
            case "RS":
                return "🏡"
            case "RUS":
                return "🇷🇺"
            case "SED":
                return "📊"
            case "SOC":
                return "👨‍👩‍👧‍👦"
            case "SOIL":
                return "💩"
            case "SPAN":
                return "🇪🇸"
            case "ST":
                return "📊"
            case "SUS":
                return "🌦"
            case "TA":
                return "🎭"
            case "TOX":
                return "😵"
            case "TCS":
                return "🏙"
            case "UEXP":
                return "🎒"
            case "VMB":
                return "🐶"
            case "WGSS":
                return "👩‍👩‍👧"
            case "WSE":
                return "🌲"
            case "WLC":
                return "🌍"
            case "WR":
                return "📝"
            case "Z":
                return "🐼"
            default:
                return "🏫"
            }
        }
        
        return "🏫"
    }
    
    /**
     Returns emoji for a section type
     
     - Parameter type: Type of a section
     - Returns: An emoji string
     */
    static func emojiFromSectionType(type: String?) -> String {
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
    
    static func emojiFromSectionProperty(property: String) -> String {
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