//
//  PostManager.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/11.
//

import Foundation

struct PostManager {
    let baseURL = "http://13.125.239.189:3000/boards"
    
    func getPost(completion: @escaping ([PostModel]?) -> ()) {
        guard let url = URL(string: baseURL) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
            } else if let data = data {
                let posts = try? JSONDecoder().decode([PostModel].self, from: data)
                
                if let posts = posts {
                    completion(posts)
                }
                
                print(posts)
                
            }
        }.resume()
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
