//
//  ToastView.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/05/23.
//

import UIKit
import SnapKit
import Then

class ToastView: UIView {
    private var message = UILabel()
        .then {
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.textColor = .white
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
}

// MARK: - Configure
extension ToastView {
    private func configureView() {
        backgroundColor = .black
        layer.opacity = 0.76
        layer.cornerRadius = 5
    }
    
    func setMessage(message: String) {
        self.addSubview(self.message)
        self.message.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        self.message.text = message
    }
}
