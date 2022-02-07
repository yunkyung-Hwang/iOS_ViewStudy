//
//  StackViewWithScrollView.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/08.
//

import UIKit

class StackViewWithScrollView: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let redView = UIView() // CustomView
        redView.backgroundColor = .red
        let blueView = UIView()
        blueView.backgroundColor = .blue

        redView.translatesAutoresizingMaskIntoConstraints = false
        blueView.translatesAutoresizingMaskIntoConstraints = false
        let imageViews = [redView, blueView]
        
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        let constraints = [
            redView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            redView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            blueView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            blueView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
