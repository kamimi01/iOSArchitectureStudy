//
//  GitHubAPI.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/06/05.
//

import Foundation

final class GithubAPI {
    struct SearchUsers: GitHubRequest {
        let keyword: String
        
        // GitHubRequestが要求する連装型
        // ここで具体的な型を指定する
        typealias Response = SearchResponse<User>
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/search/users"
        }
        
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "q", value: keyword)]
        }
    }
    
    struct SearchRepositories: GitHubRequest {
        let username: String
        let page: Int?
        
        typealias Response = SearchResponse<Repository>
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/users/\(username)/repos"
        }
        
        var queryItems: [URLQueryItem]? {
            if let page = page {
                return [URLQueryItem(name: "page", value: page.description)]
            }
            return nil
        }
    }
}
