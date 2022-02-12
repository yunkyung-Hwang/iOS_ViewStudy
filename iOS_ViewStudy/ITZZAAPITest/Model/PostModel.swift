//
//  PostData.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/11.
//

import Foundation

struct PostModel: Decodable {
    var userId: Int?
    var boardId: Int?
    var categoryName: String?
    var profileImgURL: String?
    var nickName: String?
    var postTitle: String?
    var postContent: String?
    var createdAt: String?
    var imageCnt: Int?
    var likeCnt: Int?
    var commentCnt: Int?
}
