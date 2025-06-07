//
//  NewsService.swift
//  News
//
//  Created by Muhammed Yılmaz on 5.06.2025.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchTopNews(country: String, page: Int, pageSize: Int, complition: @escaping (Result<NewsModel, NetworkError>) -> Void)
}

final class NewsService {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
}

extension NewsService: NewsServiceProtocol {
    func fetchTopNews(country: String, page: Int, pageSize: Int, complition: @escaping (Result<NewsModel, NetworkError>) -> Void) {
        var urlComponents = URLComponents(string: NetworkConstants.baseUrl + "top-headlines")
        urlComponents?.queryItems = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "pageSize", value: "\(pageSize)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apiKey", value: NetworkConstants.apiKey)
    ]
        
        guard let url = urlComponents?.url else {
            complition(.failure(.invalidRequest))
            return
        }
        
        networkManager.request(url: url, method: .GET, completion: complition)
    }
}


