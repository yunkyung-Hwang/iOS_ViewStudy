//
//  OnboardingBaseVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/23.
//

import UIKit

class OnboardingBaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if Core.shared.isNewUser() {
            let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingVC") as! OnboardingVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

class Core {
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
