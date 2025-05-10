//
//  HerfetyFormDataRequest.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 10/05/2025.
//

import Alamofire
import Foundation

struct MultipartFormDataRequest: URLRequestConvertible {
    
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
        var request = URLRequest(url: url)
        request.method = method

        let multipart = MultipartFormData()
        for (key, value) in parameters {
            if let data = "\(value)".data(using: .utf8) {
                multipart.append(data, withName: key)
            }
        }

        request.headers.add(.contentType(multipart.contentType))
        request.httpBody = try multipart.encode()
        return request
    }
}
