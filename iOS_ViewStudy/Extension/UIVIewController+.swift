//
//  UIVIewController+.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/05/23.
//

import UIKit

extension UIViewController {
    /// 화면 터치 시 키보드 내리는 함수
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// 화면 터치 시 키보드 내리는 함수
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func popupToast(toastType: ToastType) {
        let toastView = ToastView()
        view.addSubview(toastView)
        toastView.setMessage(message: toastType.message)
        
        if toastType.position == "top" {
            toastView.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().offset(-20)
                $0.height.equalTo(46)
            }
        } else {
            toastView.snp.makeConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().offset(-20)
                $0.height.equalTo(46)
            }
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseOut, animations: {
            toastView.alpha = 0.0
        }, completion: {(isCompleted) in
            toastView.removeFromSuperview()
        })
    }
}
