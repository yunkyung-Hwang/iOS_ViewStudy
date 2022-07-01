//
//  LockSettingVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/06/08.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

class LockSettingVC: UIViewController {
    let naviBar = NavigationBar()
    let bag = DisposeBag()
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
        configureContentView()
        bindUI()
    }
}

// MARK: - Configure
extension LockSettingVC {
    private func configureContentView() {
        view.backgroundColor = .systemBackground
        
        configureNaviBar()
        configureLayout()
    }

    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self, title: "화면 잠금")
        naviBar.configureBackBtn(targetVC: self, action: #selector(dismissVC), naviType: .present)
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

// MARK: - Bind
extension LockSettingVC {
    private func bindUI() {
        lockSwitch.rx.isOn
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.showLockVC()
            })
            .disposed(by: bag)
        
        lockView.rx.tapGesture()
            .when(.ended)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.lockSwitch.setOn(!self.lockSwitch.isOn, animated: true)
                self.showLockVC()
            })
            .disposed(by: bag)
    }
}

// MARK: - Custom Methods
extension LockSettingVC {
    private func showLockVC() {
        if lockSwitch.isOn {
            let lockVC = LockVC()
            lockVC.modalPresentationStyle = .overFullScreen
            present(lockVC, animated: true, completion: nil)
        }
    }
}
