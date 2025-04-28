//
//  RemoteErrorValidator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/04/2025.
//

import Foundation

/// Herfetty.com Response Validator
///
enum RemoteErrorValidator {

    /// Returns the DotcomError contained in a given Data Instance (if any).
    ///
    static func error(from response: Data) -> Error? {
        return try? JSONDecoder().decode(RemoteError.self, from: response)
    }
}
