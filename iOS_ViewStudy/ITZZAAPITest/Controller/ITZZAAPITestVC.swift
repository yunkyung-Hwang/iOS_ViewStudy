//
//  ITZZAAPITestVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/11.
//

import UIKit

class ITZZAAPITestVC: UIViewController {
    let postManager = PostManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postManager.getPostModel()
    }
}
