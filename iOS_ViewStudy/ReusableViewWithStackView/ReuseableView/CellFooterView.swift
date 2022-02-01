//
//  CellFooterView.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/01.
//

import UIKit

class CellFooterView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var likeCnt: UILabel!
    @IBOutlet weak var ChatCnt: UILabel!
    
    private static let NIB_NAME = "CellFooterView"
    
    // awakeFromNib
    override func awakeFromNib() {
        initWithNib()
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed(CellFooterView.NIB_NAME, owner: self, options: nil)
        addSubview(view)
        setupLayout()
        setUpView()
    }
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }
    
    private func setUpView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
    }
}
