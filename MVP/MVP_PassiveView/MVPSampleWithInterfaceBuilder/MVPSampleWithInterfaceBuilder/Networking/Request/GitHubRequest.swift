//
//  GitHubRequest.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/06/01.
//

import Foundation

protocol GitHubRequest {
    // リクエストの型からレスポンスの型を決定できるように、連想型を使う
    // 具体的なレスポンスの型はリクエスト時に決める
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    // HTTPリクエスト用のURLを生成する（GitHubRequestプロトコルに準拠する型をURLRequest型に変換する）
    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        switch method {
        case .get:
            components?.queryItems = queryItems
        default:
            fatalError("Unsupported method \(method)")
        }
        
        // URLRequest形に変換する
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    // URLSessionクラスを通じて、サーバから受け取ったData型とHTTPURLResponse型の値を元に、
    // レスポンスの型を表す連想型Responseの値を生成する
    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        let decoder = JSONDecoder()
        
        if case (200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
            // JSONからモデルをインスタンス化
            return try decoder.decode(Response.self, from: data)
        } else {
            // JSONからAPIエラーをインスタンス化
            throw try decoder.decode(GitHubAPIError.self, from: data)
        }
    }
}
