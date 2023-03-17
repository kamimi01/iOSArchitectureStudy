//
//  GitHubApiSession.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/18.
//

import Foundation

protocol GitHubApiRequestable {
    func searchRepositories(query: String, page: Int, completion: @escaping (Result<([Repository], Pagination), Error>) -> ())
}

final class GitHubApiSession: GitHubApiRequestable {
    static let shared = GitHubApiSession()

    private let session = Session()

    func searchRepositories(query: String, page: Int, completion: @escaping (Result<([Repository], Pagination), Error>) -> ()) {
        let request = SearchRepositoriesRequest(query: query, sort: .stars, order: .desc, page: page, perPage: nil)
        session.send(request) { result in
            switch result {
            case let .success((response, pagination)):
                completion(.success((response.items, pagination)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

