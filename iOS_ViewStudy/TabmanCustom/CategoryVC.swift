//
//  CategoryVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/05.
//

import UIKit
import Tabman
import Pageboy

class CategoryVC: TabmanViewController {
    @IBOutlet weak var categoryTB: UIView!
    
    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCategoryIndicator()
        setCategoryPageDataSource()
    }
    
    func setCategoryPageDataSource() {
        let allTab = ViewControllerFactory.viewController(for: .communityCategory) as! PostFeedVC
        let tab1 = ViewControllerFactory.viewController(for: .communityCategory) as! PostFeedVC
        let tab2 = ViewControllerFactory.viewController(for: .communityCategory) as! PostFeedVC
        let tab3 = ViewControllerFactory.viewController(for: .communityCategory) as! PostFeedVC
        let tab4 = ViewControllerFactory.viewController(for: .communityCategory) as! PostFeedVC
        
        viewControllers.append(allTab)
        viewControllers.append(tab1)
        viewControllers.append(tab2)
        viewControllers.append(tab3)
        viewControllers.append(tab4)
        self.dataSource = self
    }
    
    func setCategoryIndicator() {
        let bar = TMBar.ButtonBar()
        
        bar.backgroundView.style = .flat(color: .white)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0,
                                               left: 16.0,
                                               bottom: 0.0,
                                               right: 16.0)
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray
            button.selectedTintColor = .black
            
            button.layer.cornerRadius = 7
            button.contentInset = UIEdgeInsets(top: 0.0, left: 17.0, bottom: 0.0, right: 17.0)
        }
    
        bar.indicator.cornerStyle = .eliptical
        bar.indicator.weight = .medium
        bar.indicator.tintColor = .black
        bar.indicator.overscrollBehavior = .compress
        
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .intrinsic
        bar.layout.interButtonSpacing = 14
        bar.layout.transitionStyle = .snap
        
        addBar(bar, dataSource: self, at: .custom(view: categoryTB, layout: nil))
    }
}

//MARK: TMBarDataSource
extension CategoryVC: TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "전체")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
}

//MARK: PageboyViewControllerDataSource
extension CategoryVC: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
