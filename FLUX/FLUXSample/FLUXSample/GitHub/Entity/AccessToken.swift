//
//  AccessToken.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/18.
//

import Foundation

public struct AccessToken: Codable {
    public let accessToken: String
    public let tokenType: String
    public let scope: String

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
    }

    public init(accessToken: String, tokenType: String, scope: String) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.scope = scope
    }
}
