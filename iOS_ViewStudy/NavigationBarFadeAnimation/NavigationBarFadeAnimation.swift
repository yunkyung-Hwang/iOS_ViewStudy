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
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
       if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
           
           UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
               self.tabBarTopAnchor.constant = 0
               self.customNaviBar.layer.opacity = 0
               self.view.layoutIfNeeded()
//               self.customNaviBar.layoutIfNeeded()
               
           }, completion: nil)

       } else {
           
           UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
               self.tabBarTopAnchor.constant = 70
               self.customNaviBar.layer.opacity = 1
               self.view.layoutIfNeeded()
//               self.customNaviBar.layoutIfNeeded()
           }, completion: nil)
       }
    }
}
