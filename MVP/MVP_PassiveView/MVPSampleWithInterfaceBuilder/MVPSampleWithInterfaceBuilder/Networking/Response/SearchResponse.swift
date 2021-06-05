//
//  SearchResponse.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/06/05.
//

import Foundation

public struct SearchResponse<Item: Decodable>: Decodable {
    public let items: [Item]
}
