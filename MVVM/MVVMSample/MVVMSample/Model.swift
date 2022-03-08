//
//  Model.swift
//  MVVMSample
//
//  Created by Mika Urakawa on 2022/03/08.
//

import Foundation

enum ModelError: Error {
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
}

protocol ModelProtocol {
    func validate(idText: String?, passwordText: String?) -> Result<Void, ModelError>
}

/**
 Optional型は、noneとsome<T>で定義されている
 */
final class Model: ModelProtocol {
    func validate(idText: String?, passwordText: String?) -> Result<Void, ModelError> {
        switch (idText, passwordText) {
        case (.none, .none):
            return .failure(.invalidIdAndPassword)
        case (.none, .some):
            return .failure(.invalidId)
        case (.some, .none):
            return .failure(.invalidPassword)
        case (let idText?, let passwordText?):
            switch (idText.isEmpty, passwordText.isEmpty) {
            case (true, true):
                return .failure(.invalidIdAndPassword)
            case (false, false):
                return .success(Void())
            case (true, false):
                return .failure(.invalidId)
            case (false, true):
                return .failure(.invalidPassword)
            }
        }
    }
}
