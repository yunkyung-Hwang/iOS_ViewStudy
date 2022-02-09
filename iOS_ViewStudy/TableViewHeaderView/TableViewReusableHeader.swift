//
//  TableViewReusableHeader.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/09.
//

import UIKit

class TableViewReusableHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var profileHeaderView: ProfileHeaderView!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setContentView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setContentView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setContentView() {
        guard let view = loadViewFromNib(with: "TableViewReusableHeader") else { return }
        view.backgroundColor = .clear
        self.addSubview(view)
    }
}
extension UIView {
    func loadViewFromNib(with xibName: String) -> UIView? {
        return Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView
    }
}
