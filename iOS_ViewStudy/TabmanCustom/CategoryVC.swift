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
    
    private let viewControllers = TypeOfViewController.communityCases.compactMap {
        ViewControllerFactory.viewController(for: $0) as? PostFeedVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCategoryIndicator()
        setCategoryPageDataSource()
    }
    
    func setCategoryPageDataSource() {
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
