//
//  LockVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/05/30.
//

import UIKit
import Then
import SnapKit

class LockVC: UIViewController {
    private var viewTitle = UILabel()
        .then {
            $0.text = "암호 입력"
            $0.font = UIFont.boldSystemFont(ofSize: 24)
            $0.textColor = .label
            $0.textAlignment = .center
        }
    
    private var message = UILabel()
        .then {
            $0.text = "잠금 해제를 위한 암호를 입력해 주세요."
            $0.font = UIFont.systemFont(ofSize: 17)
            $0.textColor = .systemGray
            $0.textAlignment = .center
        }
    
    private var passwdStackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 32
        }
    
    private var keypadCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        .then {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            $0.collectionViewLayout = layout
        }
    
    private var inputPasswd = [Int]()
    private var passwd = [1,2,3,4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContentView()
        configureLayout()
        configurePasswdStackView()
        configureKeypad()
    }
}

// MARK: - Configure
extension LockVC {
    private func configureContentView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        view.addSubview(viewTitle)
        view.addSubview(message)
        view.addSubview(passwdStackView)
        view.addSubview(keypadCV)
        
        viewTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(180)
            $0.centerX.equalToSuperview()
        }
        
        message.snp.makeConstraints {
            $0.top.equalTo(viewTitle.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
        
        passwdStackView.snp.makeConstraints {
            $0.top.equalTo(message.snp.bottom).offset(62)
            $0.leading.equalToSuperview().offset(101)
            $0.trailing.equalToSuperview().offset(-101)
            $0.height.equalTo(20)
        }
        
        keypadCV.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(keypadCV.snp.width).multipliedBy(4.0/5.0)
            $0.bottom.equalToSuperview().offset(-66)
        }
    }
    
    private func configurePasswdStackView() {
        for _ in 0..<4 {
            let passwdView = UIImageView(image: UIImage(named: "passwdNull"))
            passwdStackView.addArrangedSubview(passwdView)
        }
    }
    
    private func configureKeypad() {
        keypadCV.register(KeypadCVC.self, forCellWithReuseIdentifier: "keypadCVC")
        keypadCV.dataSource = self
        keypadCV.delegate = self
    }
}

// MARK: - Custom Methods
extension LockVC {
    private func checkPasswd() {
        if inputPasswd == passwd {
            dismiss(animated: true)
        } else {
            wrongAnimation()
            UIDevice.vibrate()
        }
    }
    
    private func wrongAnimation() {
        self.passwdLayout(leading: 91, triling: -111)
        UIView.animate(withDuration:0.1,
                       delay: 0,
                       options: [.curveEaseInOut, .autoreverse, .repeat]) {
            self.view.isUserInteractionEnabled = false
             UIView.modifyAnimations(withRepeatCount: 2, autoreverses: true) {
                 self.passwdLayout(leading: 111, triling: -91)
             }
        } completion: { _ in
            self.view.isUserInteractionEnabled = true
            self.message.text = "잠금 해제를 위한 암호를 입력해 주세요."
            self.passwdLayout(leading: 101, triling: -101)
            
            for i in 0..<4 {
                let passwd = self.passwdStackView.arrangedSubviews[i] as! UIImageView
                passwd.image = UIImage(named: "passwdNull")
            }
            self.inputPasswd.removeAll()
        }
        message.text = "암호가 일치하지 않습니다."
    }
    
    private func passwdLayout(leading: CGFloat, triling: CGFloat) {
        self.passwdStackView.snp.updateConstraints {
            $0.leading.equalToSuperview().offset(leading)
            $0.trailing.equalToSuperview().offset(triling)
        }
        self.view.layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDataSource
extension LockVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "keypadCVC", for: indexPath) as? KeypadCVC else { return UICollectionViewCell() }
        
        switch indexPath.row {
        case 0..<9:
            cell.configureNumpad(with: indexPath.row + 1)
        case 10:
            cell.configureNumpad(with: 0)
        case 11:
            cell.configureBackspace()
        default:
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? KeypadCVC else { return }
        
        switch indexPath.row {
        case 0..<9, 10:
            let passwd = passwdStackView.arrangedSubviews[inputPasswd.count] as! UIImageView
            passwd.image = UIImage(named: "passwdFilled")
            inputPasswd.append(Int(cell.number.text!)!)
        case 11:
            inputPasswd.removeLast()
            let passwd = passwdStackView.arrangedSubviews[inputPasswd.count] as! UIImageView
            passwd.image = UIImage(named: "passwdNull")
        default:
            return
        }
        
        if inputPasswd.count == 4 {
            checkPasswd()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LockVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3,
                      height: collectionView.frame.height / 4)
    }
}
