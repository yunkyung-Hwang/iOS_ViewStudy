//
//  PostManager.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/11.
//

import Foundation

// delegate design pattern - reusable
protocol PostManagerDelegate {
    func didUpdatePost(_ postManager: PostManager, _ posts: [PostModel])
    func didFailWithError(_ error: Error)
}

struct PostManager {
    let baseURL = "http://13.125.239.189:3000"
    var delegate: PostManagerDelegate?
    
    func getPostModel() {
        let urlString = "\(baseURL)/boardsa"
        
        guard let url = URL(string: urlString) else {
            print("Error")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let posts = self.parseJSON(postData: data) {
                    self.delegate?.didUpdatePost(self, posts)
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
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
// TODO:
//1. create a url
//2. create a url session
//3. give the session a task
//4. start the task

//5. parseJSON
//6. delegate Design pattern
//7. method naming conventions and error handling
