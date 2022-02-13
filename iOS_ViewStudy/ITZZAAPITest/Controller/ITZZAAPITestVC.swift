//
//  ITZZAAPITestVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/11.
//

import UIKit

class ITZZAAPITestVC: UIViewController {
    var postManager = PostManager()
    var postList: [PostModel]?
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postManager.delegate = self
    }
}

extension ITZZAAPITestVC: PostManagerDelegate {
    func didFailWithError(_ error: Error) {
        print(error)
        print("여기서 에러 처리")
    }
}
