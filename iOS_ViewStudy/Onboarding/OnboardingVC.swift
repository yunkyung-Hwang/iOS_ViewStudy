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
        configure()
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
        nextBtn.setTitle("다음", for: .normal)
        
        nextBtn.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        nextBtn.tag = 1
    }
    
    func configure() {
        holderView.addSubview(scrollView)
        
        let titles = ["TITLE1", "TITLE2", "TITLE3", "TTITLE4", "TITLE5"]
        let explanations = [
            "explanations1\nexplanations",
            "explanations2\nexplanationsexplanations",
            "explanations3\nexplanationsexplanationsexplanations",
            "explanations4\nexplanationsexplanationsexplanationsexplanations",
            "explanations5\nexplanationsexplanations\nexplanationsexplanationsexplanations"]
        let images = [
            UIImage.init(systemName: "person"),
            UIImage.init(systemName: "person.fill"),
            UIImage.init(systemName: "person.fill.turn.right"),
            UIImage.init(systemName: "person.fill.turn.down"),
            UIImage.init(systemName: "person.fill.turn.left")]
        
        for i in 0..<5 {
            let pageView = UIView(frame: CGRect(x: CGFloat(i) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            let imageView = UIImageView(frame: CGRect(x: 65, y: 100, width: pageView.frame.size.width - 130, height: 276))
            let title = UILabel(frame: CGRect(x: 10, y: 430, width: pageView.frame.size.width - 20, height: 34))
            let explanation = UITextView(frame: CGRect(x: 10, y: 430 + 34 + 25, width: pageView.frame.size.width - 20, height: 70))
            
            title.textAlignment = .center
            title.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            pageView.addSubview(title)
            title.text = titles[i]
            
            explanation.textAlignment = .center
            explanation.font = UIFont.systemFont(ofSize: 15)
            pageView.addSubview(explanation)
            explanation.text = explanations[i]
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = images[i]
            pageView.addSubview(imageView)
        }
    }
    @objc func didTapButton(_ button: UIButton) {
        guard button.tag < 5 else {
            return
        }
        
        if button.tag == 4{
            let btnTitle = NSAttributedString(string: "시작하기")
            button.setAttributedTitle(btnTitle, for: .normal)
        }
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }
}
extension OnboardingVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        pageController.currentPage = currentIndex
        nextBtn.tag = pageController.currentPage + 1
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
