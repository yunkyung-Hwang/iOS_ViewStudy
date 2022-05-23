//
//  ToastType.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/05/23.
//

import Foundation

enum ToastType: String {
    case changeDarkmode
    case changeLightmode
}

extension ToastType {
    var position: String {
        switch self {
        case .changeDarkmode, .changeLightmode:
            return "bottom"
        }
    }
    
    var message: String {
        switch self {
        case .changeDarkmode:
            return "다크모드로 변경되었습니다."
        case .changeLightmode:
            return "라이트모드로 변경되었습니다."
        }
    }
}
