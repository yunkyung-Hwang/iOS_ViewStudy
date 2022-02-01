//
//  CommunityVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/01.
//

import UIKit

class CommunityVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Community"
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CommunityVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityCell", for: indexPath) as! CommunityTVC
        
//        cell.cellHeaderView.profileImg.image = UIImage(named: "person.circle.fill")
        cell.cellHeaderView.profileImg.image = UIImage(systemName: "person.circle.fill")
        cell.cellHeaderView.userName.text = "익명의 사용자"
        
        cell.cellFooterView.likeCnt.text = "\(10 + indexPath.row)"
        cell.cellFooterView.ChatCnt.text = "\(5 + indexPath.row)"
        return cell
    }
}

extension CommunityVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
