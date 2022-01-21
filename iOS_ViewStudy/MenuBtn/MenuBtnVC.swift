//
//  DeleteCellByMenuVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/22.
//

import UIKit

class MenuBtnVC: UIViewController {
    var DataArr = ["a","bb","ccc","dddd"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteCell), name: NSNotification.Name(rawValue: "cellDelete"), object: nil)
    }
    
    @objc func deleteCell(_ notification: NSNotification) {
        let indexPath = notification.object as! IndexPath
        
        // 순서 중요!
        DataArr.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        tableView.reloadData()
    }
}

extension MenuBtnVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuBtnTVC
        cell.textField.text = DataArr[indexPath.row]
        cell.indexPath = indexPath
        
        return cell
    }
}
extension MenuBtnVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택상태로 남아있지 않게
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
