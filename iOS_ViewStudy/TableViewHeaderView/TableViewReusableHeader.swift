//
//  TableViewReusableHeader.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/09.
//

import UIKit

class TableViewReusableHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var profileHeaderView: ProfileHeaderView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UILabel!
    
    var image:[UIImage] = []
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }    
    
    func setContentView() {
        guard let view = loadViewFromNib(with: "TableViewReusableHeader") else { return }
        self.addSubview(view)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.numberOfLines = 0
        textView.lineBreakMode = .byCharWrapping
        
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
//        view.frame = bounds
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)

        scrollView.isScrollEnabled = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageViews = image.map { image -> UIImageView in
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
        
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        let constraints = [
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            scrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
