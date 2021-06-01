//
//  GithubClientError.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/06/01.
//

import Foundation

enum GitHubClientError: Error {
    // 通信に失敗
    case connectionError(Error)
    
    // レスポンスのパースに失敗
    case responseParseError(Error)
    
    // APIからエラーレスポンスw受け取った
    case apiError(GitHubAPIError)
}
