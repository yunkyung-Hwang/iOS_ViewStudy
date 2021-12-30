//
//  ViewController.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2021/12/31.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var movingView: UIView!
    @IBOutlet weak var viewIndicator: UIView!
    @IBOutlet weak var movingViewHeight: NSLayoutConstraint!
    
    var isMonth = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // view setUp
        movingView.layer.cornerRadius = 40
        viewIndicator.layer.cornerRadius = viewIndicator.frame.height / 2
        
        // panGesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(scrollVertical))
        movingView.addGestureRecognizer(panGesture)
    }
    
    @objc func scrollVertical(sender: UIPanGestureRecognizer) {
        let dragPosition = sender.translation(in: self.view)

        switch sender.state {
        case .changed:
            if isMonth {
                movingViewHeight.constant = 453 + dragPosition.y
            } else {
                movingViewHeight.constant = 200 + dragPosition.y
            }
        case .ended:
            if movingViewHeight.constant < 300{
                self.movingViewHeight.constant = 200
                isMonth = false
            } else {
                self.movingViewHeight.constant = 453
                isMonth = true
            }

        default:
            break
        }
    }
}
