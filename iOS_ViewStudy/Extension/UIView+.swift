//
//  UIView+.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/07/01.
//

import UIKit

extension UIView {
    func loadViewFromNib(with xibName: String) -> UIView? {
        return Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView
    }
    
    /// View를 UIImage로 변환해주는 함수
    func transfromToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
}
