//
//  UILabel+.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/07/01.
//

import UIKit

extension UILabel {
    /// 여러 줄 보기
    func setLineBreakMode() {
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        lineBreakMode = .byCharWrapping
    }
}
