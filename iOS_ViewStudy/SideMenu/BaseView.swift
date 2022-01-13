//
//  BaseView.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/13.
//

import UIKit
import SideMenu

class BaseView: UIViewController {
    override func viewDidLoad() {
        
    }
    @IBAction func showSideMenu(_ sender: Any) {
        guard let sideMenuVC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenu") as? SideMenuNavigationController else {return}
        sideMenuVC.presentationStyle.onTopShadowColor = .black
        sideMenuVC.presentationStyle.onTopShadowOpacity = 0.5
        sideMenuVC.presentationStyle.onTopShadowOffset = CGSize(width: 0, height: 0)
        sideMenuVC.presentationStyle.onTopShadowRadius = 10
        
        present(sideMenuVC, animated: true, completion: nil)
    }
}
