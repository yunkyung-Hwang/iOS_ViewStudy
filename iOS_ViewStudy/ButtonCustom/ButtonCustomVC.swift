//
//  ButtonCustomVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/04.
//

import UIKit

class ButtonCustomVC: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "buttonImg")?.withRenderingMode(.alwaysTemplate)
        
        button.setTitle("", for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = .systemIndigo
        
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapButton(_ button: UIButton) {
        //TODO: - setTitle과 setAttributedTitle 차이?
        //TODO: - string과 NSAttributedString 차이?
        
//        button.setTitle("changed", for: .normal)
        
//        let btnTitle = NSAttributedString(string: "시작하기")
//        button.setAttributedTitle(btnTitle, for: .normal)
    }
}
