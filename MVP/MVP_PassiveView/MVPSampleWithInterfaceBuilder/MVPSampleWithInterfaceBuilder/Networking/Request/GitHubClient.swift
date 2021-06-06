//
//  GitHubClient.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/06/06.
//

import Foundation

class GitHubClient {
    // HTTPクライアント
    private let session: URLSession = {
        // URLSessionConfigurationはURLSessionの設定を提供する
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    // <>はジェネリクスという。複数の型を引数に取りたい場合に、その引数の型を指定する
    // SearchUsersのRequest型が引数になる場合もあれば、SearchRepositoriesのRequest型が引数になる場合もある
    // どちらもGitHubRequest型には準拠している
    func send<Request: GitHubRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, GitHubClientError>) -> Void) {
        // URLRequest型のインスタンスを作成
        let urlRequest = request.buildURLRequest()
        // 内部的に保持しているURLSessionクラスのインスタンスに渡す
        let task = session.dataTask(with: urlRequest) {
            data, response, error in
            
            // エラーの場合（errorがnilではない場合）
            if let error = error {
                // 呼び出し元に処理を戻す
                completion(Result(error: .connectionError(error)))
                return
            }
            
            // 処理が行われた場合（dataとresponseがnilではない場合）
            // if let letと続けることでまとめてアンラップが可能
            if let data = data, let response = response {
                do {
                    // 成功しているので、モデルへのマッピングを行う
                    let response = try request.response(from: data, urlResponse: response)
                    completion(Result(value: response))
                } catch let error as GitHubAPIError {
                    completion(Result(error: .apiError(error)))
                } catch {
                    completion(Result(error: .responseParseError(error)))
                }
            }
        }
        
        // HTTPリクエストを送信する
        task.resume()
    }
}
