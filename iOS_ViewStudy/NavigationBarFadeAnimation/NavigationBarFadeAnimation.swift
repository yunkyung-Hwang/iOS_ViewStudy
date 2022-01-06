//
//  NavigationBarFadeAnimation.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2021/12/31.
//

import UIKit

class NavigationBarFadeAnimation: UIViewController {
    @IBOutlet weak var customNaviBar: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryBarView: UIView!
    @IBOutlet weak var tabBarTopAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension NavigationBarFadeAnimation: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { fatalError() }
        return cell
    }
}

extension NavigationBarFadeAnimation: UITableViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0) {
            UIView.animate(withDuration: 0.4, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.tabBarTopAnchor.constant = 0
                self.categoryBarView.layoutIfNeeded()
                self.customNaviBar.isHidden = true
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.tabBarTopAnchor.constant = 70
                self.categoryBarView.layoutIfNeeded()
                self.customNaviBar.isHidden = false
            }, completion: nil)
        }
    }
}
