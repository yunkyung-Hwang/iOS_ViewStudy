//
//  DeleteCellByMenuVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/22.
//

import UIKit

class DeleteCellByMenuVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }
}

extension DeleteCellByMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
}
extension DeleteCellByMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택상태로 남아있지 않게
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
