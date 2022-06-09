//
//  LockSettingVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/06/08.
//

import UIKit
import Then
import SnapKit

class LockSettingVC: UIViewController {
    let naviBar = NavigationBar()
    private var lockView = UIView()
    private var lockTitle = UILabel()
        .then {
            $0.text = "화면 잠금"
            $0.textColor = .label
            $0.font = UIFont.systemFont(ofSize: 17)
        }
    private var lockSwitch = UISwitch()
        .then {
            $0.onTintColor = .black
        }
    
    private var warningMessage = UILabel()
        .then {
            $0.text = "⚠ 비밀번호 분실 시 앱을 삭제하고 재설치 해야하며 저장된 미디어는 모두 삭제됩니다."
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textColor = .red
            $0.setLineBreakMode()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        configureContentView()
        configureLayout()
    }
}

// MARK: - Configure
extension LockSettingVC {
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self, title: "화면 잠금")
        naviBar.configureBackBtn(targetVC: self, action: #selector(popVC), naviType: .push)
    }
    
    private func configureContentView() {
        view.backgroundColor = .systemBackground
        addGesturelockGesture()
    }
    
    private func configureLayout() {
        view.addSubview(lockView)
        lockView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(53)
        }
        
        lockView.addSubview(lockTitle)
        lockTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        lockView.addSubview(lockSwitch)
        lockSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(warningMessage)
        warningMessage.snp.makeConstraints {
            $0.top.equalTo(lockView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}

// MARK: - Custom Methods
extension LockSettingVC {
    private func addGesturelockGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTaplockView))
        lockView.addGestureRecognizer(gesture)
    }
    
    @objc func didTaplockView() {
        lockSwitch.setOn(!lockSwitch.isOn, animated: true)
    }
}

extension UILabel {
    /// 여러 줄 보기
    func setLineBreakMode() {
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        lineBreakMode = .byCharWrapping
    }
}
