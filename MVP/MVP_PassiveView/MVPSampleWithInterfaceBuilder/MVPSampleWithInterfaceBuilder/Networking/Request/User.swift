//
//  User.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/06/01.
//

import Foundation

struct User: Decodable {
    let id: String
    let login: String
    let avatarURL: String
    let htmlURL: String
    
    // プロパティ名とJSONのキーの対応関係を定義する
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }
}
