//
//  UserDetailModel.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/05/27.
//

import Foundation

// GitHubAPIへのリクエストは、Modelで行う
protocol SearchUserModelInput {
    func fetchUser(
        query: String,
        // このクロージャーはこの関数のスコープ外で参照されるので、@escapingが必要
        completion: @escaping (Result<[User], GitHubClientError>) -> ())
}

final class SearchUserModel: SearchUserModelInput {
    func fetchUser(
        query: String,
        completion: @escaping (Result<[User], GitHubClientError>) -> ()) {
        
        // APIクライアントの生成
        let client = GitHubClient()
        
        // リクエストの発行
        let request = GithubAPI.SearchUsers(keyword: query)
        
        client.send(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
