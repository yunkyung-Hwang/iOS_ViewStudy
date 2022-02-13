//
//  ITZZAAPITestVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/11.
//

import UIKit

class ITZZAAPITestVC: UIViewController {
    var postManager = PostManager()
    var postList: [PostModel]?
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postManager.delegate = self
        postManager.getPostModel()
    }
}

extension ITZZAAPITestVC: PostManagerDelegate {
    func didUpdatePost(_ postManager: PostManager, _ posts: [PostModel]) {
        postList = posts
        postList?.forEach({ post in
            print("userId: ", post.userId ?? 0)
            print("boardId: ", post.boardId ?? 0)
            print("categoryName: ", post.categoryName ?? "")
            print("profileImgURL: ", post.profileImgURL ?? "")
            print("nickName: ", post.nickName ?? "")
            print("postTitle: ", post.postTitle ?? "")
            print("postContent: ", post.postContent ?? "")
            print("createdAt: ", post.createdAt ?? "")
            print("imageCnt: ", post.imageCnt ?? 0)
            print("likeCnt: ", post.likeCnt ?? 0)
            print("commentCnt: ", post.commentCnt ?? 0)
            print()
            
            // UI변경은 항상 main thread 안에서! 아니면 앱 죽음
            DispatchQueue.main.async {
                self.textView.text = self.postList?[0].postTitle ?? ""
                self.textView.text += "\n"
                self.textView.text += self.postList?[0].postContent ?? ""
                self.textView.text += "\n"
                self.textView.text += self.postList?[0].createdAt ?? ""
            }
        })
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
        print("여기서 에러 처리")
    }
}
