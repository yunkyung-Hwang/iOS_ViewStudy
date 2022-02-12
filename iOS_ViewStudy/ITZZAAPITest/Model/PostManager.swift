//
//  PostManager.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/11.
//

import Foundation

// delegate design pattern - reusable
protocol PostManagerDelegate {
    func didUpdatePost(posts: [PostModel])
}

struct PostManager {
    let baseURL = "http://13.125.239.189:3000"
    var delegate: PostManagerDelegate?
    
    func getPostModel() {
        let urlString = "\(baseURL)/boards"
        
        guard let url = URL(string: urlString) else {
            print("Error")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let posts = self.parseJSON(postData: data) {
                    self.delegate?.didUpdatePost(posts: posts)
                }
            }
        }.resume()
    }
    
    func parseJSON(postData: Data) -> [PostModel]? {
        let decoder = JSONDecoder()
        do {
            let decodeData: [PostModel] = try decoder.decode([PostModel].self, from: postData)
            return decodeData
        } catch {
            print(error)
            return nil
        }
    }
}
// TODO:
//1. create a url
//2. create a url session
//3. give the session a task
//4. start the task
