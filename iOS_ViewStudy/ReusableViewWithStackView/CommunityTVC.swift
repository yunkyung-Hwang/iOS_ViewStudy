//
//  CommunityTVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/01.
//

import UIKit

class CommunityTVC: UITableViewCell {
    @IBOutlet weak var cellHeaderView: ProfileHeaderView!
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var cellFooterView: CellFooterView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contents.isScrollEnabled = false
        contents.isEditable = false
        contents.isSelectable = false
        contents.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
