//
//  Result.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/06/06.
//

import Foundation

// 成功時には、型引数Requestの連想型Responseの値を受け取る
// つまりSearchUsersをリクエストした場合は、SearchResponse<User>を受け取り、SearchRepositoriesをリクエストした場合は、SearchResponse<Repository>を受け取る
// 失敗した場合は、GitHubClientErrorを受け取る
enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value: T) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
}
