//
//  ITZZAAPITestVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/11.
//

import UIKit

class ITZZAAPITestVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var postListVM: PostListVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        setPost()
    }
    
    private func setPost() {
        PostManager().getPost { posts in
            if let posts = posts {
                self.postListVM = PostListVM(posts: posts)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print("done")
                }
            }
        }
    }
}

extension ITZZAAPITestVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.postListVM == nil ? 0 : self.postListVM.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostTVC else {
            fatalError("postTVC not found")
        }
        
        let postVM = self.postListVM.postAtIndex(indexPath.row)
        
        cell.postTitle.text = postVM.postTitle
        cell.postContents.text = postVM.postContents
        cell.profileImgURL.text = postVM.profileImgURL
        cell.nickName.text = postVM.nickname
        cell.createAt.text = postVM.createAt
        
        return cell
    }
}
