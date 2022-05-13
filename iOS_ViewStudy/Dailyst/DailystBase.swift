//
//  DailystBase.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/05/09.
//

import UIKit

class DailystBase: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showAddProcess(_ sender: Any) {
        let addVC = Dailyst()
//        addVC.modalPresentationStyle = .overFullScreen
//        present(addVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(addVC, animated: true)
    }
}
