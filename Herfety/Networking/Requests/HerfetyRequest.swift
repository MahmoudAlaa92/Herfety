//
//  HerfetyRequest.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/04/2025.
//

import Alamofire
import Foundation

/// Represents Fakestore.com Endpoint
///
struct HerfetyRequest: URLRequestConvertible {

    /// HTTP Request Method
    ///
    let method: HTTPMethod

    /// URL Path
    ///
    let path: String

    /// Parameters
    ///

    let parameters: [String: Sendable]

    /// Designated Initializer.
    ///
    /// - Parameters:
    ///     - method: HTTP Method we should use.
    ///     - path: RPC that should be called.
    ///     - parameters: Collection of Key/Value parameters, to be forwarded to the Jetpack Connected site.
    ///

    init(method: HTTPMethod, path: String, parameters: [String: Sendable]? = nil) {
        self.method = method
        self.path = path
        self.parameters = parameters ?? [:]
    }

    /// Returns a URLRequest instance reprensenting the current harfty Request.
    ///
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Settings.storeApiBaseURL + path)!
        let request = try URLRequest(url: url, method: method, headers: nil)
        let encodedRequest = try encoder.encode(request, with: parameters)

        // 🔍 DEBUG: Print final URL with parameters
        if let finalURL = encodedRequest.url {
            print("📡 Final Request URL:\(finalURL.absoluteString)")
        } else {
            print("❌ Failed to build final URL")
        }

        return encodedRequest
    }
}

// MARK: - Herfety Request
//
private extension HerfetyRequest {

    /// Returns the Parameters Encoder
    ///
    var encoder: ParameterEncoding {

        return method == .get || method == .delete ? URLEncoding.queryString : JSONEncoding.default // URLEncoding.httpBody
    }
}
