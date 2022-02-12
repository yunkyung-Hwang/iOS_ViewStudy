//
//  PostManager.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/11.
//

import Foundation

struct PostManager {
    let baseURL = "http://13.125.239.189:3000"
    
    func getPostModel() {
        let urlString = "\(baseURL)/boards"
        
        guard let url = URL(string: urlString) else {
            print("Error")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let resArray: [PostModel] = try
                    JSONDecoder().decode([PostModel].self, from: data)
                    print(resArray)
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}
