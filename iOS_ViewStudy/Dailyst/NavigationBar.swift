//
//  NavigationBar.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/05/23.
//

import UIKit
import SnapKit
import Then
import RxSwift

class NavigationBar: UIView {
    private var title = UILabel()
        .then {
            $0.font = UIFont.systemFont(ofSize: 20)
        }
    
    private var backBtn = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .label
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayout()
    }
}

// MARK: - Configure
extension NavigationBar {
    func configureLayout() {
        self.addSubview(title)
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configureNaviBar(targetVC: UIViewController, title: String) {
        targetVC.view.addSubview(self)
        self.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.leading.trailing.equalTo(targetVC.view.safeAreaLayoutGuide)
        }
        
        self.title.text = title
    }
    
    func configureBackBtn(targetVC: UIViewController, action: Selector, naviType: NaviType) {
        self.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(26)
        }
        backBtn.setImage(naviType.backBtnImage, for: .normal)
        backBtn.addTarget(targetVC, action: action, for: .touchUpInside)
    }
    
    func configureRightBarBtn(targetVC: UIViewController, action: Selector, image: UIImage) {
        let rightBtn = UIButton()
        self.addSubview(rightBtn)
        rightBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.width.equalTo(26)
        }
        rightBtn.setImage(image, for: .normal)
        rightBtn.addTarget(targetVC, action: action, for: .touchUpInside)
    }
    
    func configureRightBarBtn(targetVC: UIViewController, action: Selector, title: String) {
        let rightBtn = UIButton()
        self.addSubview(rightBtn)
        rightBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(26)
        }
        rightBtn.setTitle(title, for: .normal)
        rightBtn.setTitleColor(.label, for: .normal)
        rightBtn.addTarget(targetVC, action: action, for: .touchUpInside)
    }
}
