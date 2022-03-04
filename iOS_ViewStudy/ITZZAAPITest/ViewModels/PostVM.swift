//
//  PostVM.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/13.
//

import Foundation

//PostVM 상위
struct PostListVM {
    let posts: [PostModel]
}

extension PostListVM {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.posts.count
    }
    
    func postAtIndex(_ index: Int) -> PostVM {
        let post = self.posts[index]
        return PostVM(post) 
    }
}


//MARK: - PostVM
struct PostVM {
    private let post: PostModel
}

extension PostVM {
    init (_ post: PostModel) {
        self.post = post
    }
}

extension PostVM {
    var nickname: String {
        return self.post.nickname ?? ""
    }
    
    var profileImgURL: String {
        return self.post.profileImage ?? ""
    }
    
    var createAt: String {
        return self.post.createdAt ?? ""
    }
    
    var postTitle: String {
        return self.post.postTitle ?? ""
    }
    
    var postContents: String {
        return self.post.postContent ?? ""
    }
}
