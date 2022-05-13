//
//  EmotionType.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/05/09.
//

import UIKit

enum EmotionType: CaseIterable {
    case happy
    case flutter
    case comfortable
    case notGood
    case sad
}

extension EmotionType {
    var emotionImage: UIImage {
        switch self {
        case .happy:
            return UIImage(named: "Emoji_Happy") ?? UIImage()
        case .flutter:
            return UIImage(named: "Emoji_Flutter") ?? UIImage()
        case .comfortable:
            return UIImage(named: "Emoji_Comfortable") ?? UIImage()
        case .notGood:
            return UIImage(named: "Emoji_NotGood") ?? UIImage()
        case .sad:
            return UIImage(named: "Emoji_Sad") ?? UIImage()
        }
    }
    
    var emotionTitle: String {
        switch self {
        case .happy:
            return "신나요"
        case .flutter:
            return "설레요"
        case .comfortable:
            return "평온해요"
        case .notGood:
            return "별로예요"
        case .sad:
            return "슬퍼요"
        }
    }
}
