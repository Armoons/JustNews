//
//  NewsModel.swift
//  JustNews
//
//  Created by Stepanyan Arman  on 04.02.2023.
//

import Foundation
import UIKit

struct NewsModelArray: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title, description: String
    let url: URL
    let urlToImage: URL
    let publishedAt: String
    let content: String?    
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}


//struct NewsModelArray: Decodable {
//    let articles: [NewsParserModel]
//    let status: String
//    let
//
//}
//
//struct NewsSource: Codable {
//    let id: String
//    let name: String
//}
//
//class NewsParserModel: Codable {
////    var source: NewsSource
//    var title: String
////    var description: String
////    var url: URL
////    var urlToImage: URL
////    var publishedAt: String
////    var viewsNumber: Int?
//
//    init(title: String) {
//        self.title = title
//    }
//
////    init(source: NewsSource,  title: String,  description: String,  url: URL,  urlToImage: URL,  publishedAt: String) {
////        self.source = source
////        self.title = title
////        self.description = description
////        self.url = url
////        self.urlToImage = urlToImage
////        self.publishedAt = publishedAt
////    }
//}


struct NewsModelCache {
    
    static let key = "NewsModelCache"
    static func save(value: [Article]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    
    static func get() -> [Article] {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            do {
                let newsData = try PropertyListDecoder().decode([Article].self, from: data)
                return newsData
            }
            catch {
                print(error.localizedDescription)
                return []
            }
        } else {
            return []
        }
    }
    
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}



