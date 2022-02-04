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
    }
}
