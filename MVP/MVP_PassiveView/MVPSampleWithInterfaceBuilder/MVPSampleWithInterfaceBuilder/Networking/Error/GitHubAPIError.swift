//
//  GitHubAPIError.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/06/01.
//

import Foundation

struct GitHubAPIError: Decodable, Error {
    let message: String
}
