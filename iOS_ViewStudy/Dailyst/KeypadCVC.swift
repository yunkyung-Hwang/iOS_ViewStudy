//
//  KeypadCVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/05/30.
//

import UIKit
import Then
import SnapKit

class KeypadCVC: UICollectionViewCell {
    var number = UILabel()
        .then {
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.textColor = .label
            $0.textAlignment = .center
        }
    
    private var backspace = UIImageView()
        .then {
            $0.image = UIImage(named: "backspace")?.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .label
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureNumpad(with num: Int) {
        addSubview(number)
        number.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        number.text = "\(num)"
    }
    
    func configureBackspace() {
        addSubview(backspace)
        backspace.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
