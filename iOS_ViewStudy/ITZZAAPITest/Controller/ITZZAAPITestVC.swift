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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postManager.delegate = self
        postManager.getPostModel()
    }
}

extension ITZZAAPITestVC: PostManagerDelegate {
    func didUpdatePost(posts: [PostModel]) {
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
        })
    }
}
