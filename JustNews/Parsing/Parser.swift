//
//  Parser.swift
//  JustNews
//
//  Created by Stepanyan Arman  on 04.02.2023.
//

import Foundation

class Parser {
    typealias ResultCompletion = (Result<[Article], Error>) -> ()

    func getInfo(page: Int, completion: @escaping ResultCompletion) {
        guard let url = Self.findRepositories(page: page) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            guard let data = data else { return }
            
            do {
                let userInfo = try JSONDecoder().decode(NewsModelArray.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(userInfo.articles))
                }
            }  catch {
//                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    static func findRepositories(page: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        
        components.queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "category", value: "business"),
            URLQueryItem(name: "apiKey", value: "d50b2adeb2e64628aaa3327352b6dfe4"),
            URLQueryItem(name: "pageSize", value: "15"),
            URLQueryItem(name: "page", value: "\(page)"),

        ]
        
        return components.url
    }
}







