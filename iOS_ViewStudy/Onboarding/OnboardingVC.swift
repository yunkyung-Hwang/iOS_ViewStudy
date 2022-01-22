//
//  OnboardingVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/23.
//

import UIKit

class OnboardingVC: UIViewController {
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    
    let scrollView = UIScrollView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScrollView()
        setPageController()
        setBtn()
    }
    
    func setScrollView() {
        scrollView.delegate = self
        
        scrollView.frame = holderView.bounds
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 5, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    func setPageController() {
        pageController.numberOfPages = 5
        pageController.currentPage = 0
        pageController.pageIndicatorTintColor = .systemGray3
        pageController.currentPageIndicatorTintColor = .systemIndigo
    }
    
    func setBtn() {
        nextBtn.backgroundColor = .systemIndigo
        nextBtn.tintColor = .white
        nextBtn.layer.cornerRadius = nextBtn.frame.height / 2
    }
}
extension OnboardingVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        pageController.currentPage = currentIndex
        nextBtn.tag = pageController.currentPage + 1
        print(pageController.currentPage)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if nextBtn.tag == 4 {
            let btnTitle = NSAttributedString(string: "시작하기")
            nextBtn.setAttributedTitle(btnTitle, for: .normal)
        } else {
            let btnTitle = NSAttributedString(string: "다음")
            nextBtn.setAttributedTitle(btnTitle, for: .normal)
        }
    }
}
