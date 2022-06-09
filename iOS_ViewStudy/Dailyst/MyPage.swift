//
//  MyPage.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/05/23.
//

import UIKit
import SnapKit
import Then

class MyPage: UIViewController {
    let naviBar = NavigationBar()
    let myMediaLabel = UILabel()
        .then {
            $0.text = "나의 미디어"
            $0.font = UIFont.systemFont(ofSize: 15)
        }
    
    let mediaCnt = UILabel()
        .then {
            $0.font = UIFont.systemFont(ofSize: 15)
        }
    
    let separaterLine = UIView()
        .then {
            $0.backgroundColor = UIColor.lightGray
        }
    
    private var darkModeBtn = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "shield.fill"), for: .normal)
            $0.setTitle("다크 모드", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            $0.tintColor = .label
            $0.setTitleColor(.label, for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 255)
        }
    
    private var lockBtn = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "shield.fill"), for: .normal)
            $0.setTitle("어플 잠금", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            $0.tintColor = .label
            $0.setTitleColor(.label, for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 255)
            $0.addTarget(self, action: #selector(showLockSettingVC), for: .touchUpInside)
        }
    
    private var versionBtn = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "shield.fill"), for: .normal)
            $0.setTitle("버전 정보", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            $0.tintColor = .label
            $0.setTitleColor(.label, for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 255)
        }
    
    private var logoutBtn = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "shield.fill"), for: .normal)
            $0.setTitle("로그아웃", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            $0.tintColor = .label
            $0.setTitleColor(.label, for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 258)
        }
    
    private var signoutBtn = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "shield.fill"), for: .normal)
            $0.setTitle("회원 탈퇴", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            $0.tintColor = .label
            $0.setTitleColor(.label, for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 255)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        configureContentView()
        configureLayout()
        configureMyMedia()
    }
}

// MARK: - Configure
extension MyPage {
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self, title: "MyPage")
        naviBar.configureBackBtn(targetVC: self, action: #selector(popVC), naviType: .present)
    }
    
    private func configureContentView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        view.addSubview(myMediaLabel)
        myMediaLabel.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(25)
        }
        
        view.addSubview(mediaCnt)
        mediaCnt.snp.makeConstraints {
            $0.centerY.equalTo(myMediaLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-35)
        }
        
        view.addSubview(separaterLine)
        separaterLine.snp.makeConstraints {
            $0.top.equalTo(myMediaLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
        
        let stackView = UIStackView()
            .then {
                $0.axis = .vertical
                $0.alignment = .fill
                $0.distribution = .fill
                $0.spacing = 8
            }
        view.addSubview(stackView)
        stackView.addArrangedSubview(darkModeBtn)
        stackView.addArrangedSubview(lockBtn)
        stackView.addArrangedSubview(versionBtn)
        stackView.addArrangedSubview(logoutBtn)
        stackView.addArrangedSubview(signoutBtn)
        darkModeBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview()
        }

        lockBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview()
        }

        versionBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview()
        }

        logoutBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview()
        }

        signoutBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(separaterLine.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func configureMyMedia() {
        mediaCnt.text = "\(0)개"
        darkModeBtn.addTarget(self, action: #selector(toggleDarkMode), for: .touchUpInside)
    }
    
    @objc func toggleDarkMode() {
        if self.overrideUserInterfaceStyle == .dark {
            overrideUserInterfaceStyle = .light
            UserDefaults.standard.set("Light", forKey: "Appearance")
            popupToast(toastType: .changeLightmode)
        } else {
            overrideUserInterfaceStyle = .dark
            UserDefaults.standard.set("Dark", forKey: "Appearance")
            popupToast(toastType: .changeDarkmode)
        }
        self.viewWillAppear(true)
    }
    
    @objc func showLockSettingVC() {
        let lockSettingVC = LockSettingVC()
        self.navigationController?.pushViewController(lockSettingVC, animated: true)
    }
}
