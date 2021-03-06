//
//  NaviType.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/05/23.
//

import UIKit

enum NaviType {
    case push
    case present
}

extension NaviType {
    var backBtnImage: UIImage {
        switch self {
        case .push:
            return UIImage(systemName: "chevron.backward") ?? UIImage()
        case .present:
            return UIImage(systemName: "xmark") ?? UIImage()
        }
    }
}
