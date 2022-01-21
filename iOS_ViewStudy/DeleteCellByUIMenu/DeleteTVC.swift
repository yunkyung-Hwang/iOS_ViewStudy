//
//  DeleteTVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/22.
//

import UIKit

class DeleteTVC: UITableViewCell {
    @IBOutlet weak var button: UIButton!
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "수정",
                     image: UIImage(systemName: "pencil"),
                     handler: { _ in print("수정")}),
            UIAction(title: "삭제",
                     image: UIImage(systemName: "trash"),
                     attributes: .destructive,
                     handler: { _ in print("삭제")})
        ]
    }
    var menu: UIMenu {
        return UIMenu(title: "",
                      image: UIImage(systemName: "MoreBtn"),
                      identifier: nil,
                      options: [],
                      children: menuItems)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.menu = menu
        // 길게 안눌러도 바로 메뉴 나오게
        button.showsMenuAsPrimaryAction = true
    }
}
