//
//  DeleteTVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/22.
//

import UIKit

class MenuBtnTVC: UITableViewCell {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var indexPath: IndexPath!
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "수정",
                     image: UIImage(systemName: "pencil"),
                     handler: { [self] _ in editText()}),
            UIAction(title: "삭제",
                     image: UIImage(systemName: "trash"),
                     attributes: .destructive,
                     handler: { [self] _ in deleteCell()})
        ]
    }
    var menu: UIMenu {
        return UIMenu(title: "",
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
    
    func editText() {
        print("edit")
    }
    
    func deleteCell() {
        print("delete")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cellDelete"), object: indexPath)
    }
}
