//
//  UITextView+.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/07/01.
//

import UIKit

extension UITextView {
    func setTextViewPlaceholder(_ placeholder: String) {
        if text == "" {
            text = placeholder
            textColor = .lightGray
        }
    }
    
    func alignTextVerticallyInContainer() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
}
