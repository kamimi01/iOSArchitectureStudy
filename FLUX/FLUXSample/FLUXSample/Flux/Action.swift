//
//  Action.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/17.
//

import Foundation

// enum で定義することで、以下のメリットがある
// - type の記入ミスがなくなる
// - type に対する data の型も1対1で表せる
// - default を書く必要がないので、取りこぼしが起こらなくなる
enum Action {
    case addRepositories([Repository])
    case clearRepositories
    case selectedRepository(Repository)
}
