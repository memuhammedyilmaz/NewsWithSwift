//
//  NewsModel.swift
//  News
//
//  Created by Muhammed Yılmaz on 5.06.2025.
//

import Foundation

struct NewsModel: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String?
    let description: String?
}
    
    
