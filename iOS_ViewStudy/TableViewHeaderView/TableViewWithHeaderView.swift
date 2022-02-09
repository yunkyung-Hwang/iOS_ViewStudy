//
//  TableViewWithHeaderView.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/09.
//

import UIKit

class TableViewWithHeaderView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let images: [UIImage] = [
        UIImage(named: "test1")!,
        UIImage(named: "test2")!,
        UIImage(named: "test3")!
    ]
    
    let text = "ㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹ\nㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹ\nㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        tableView.estimatedSectionFooterHeight = 200
//        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        tableView.register(TableViewReusableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
    }
}

extension TableViewWithHeaderView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
}

extension TableViewWithHeaderView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TableViewReusableHeader
        headerView.image = images
        headerView.setContentView()
        headerView.textView.text = text
        
        headerView.profileHeaderView.userName.text = "yunkyung-Hwang"
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
