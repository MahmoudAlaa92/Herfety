//
//  AlamofireNetwork.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/04/2025.
//
import Alamofire
import Combine
import Foundation

/// AlamofireWrapper: Encapsulates all of the Alamofire OP's
///
class AlamofireNetwork: Network {
    public init() {}

    /// Executes the specified Network Request. Upon completion, the payload will be sent back to the caller as a Data instance.
    ///
    public func responseData(for request: URLRequestConvertible, completion: @escaping (Result<Data, Error>) -> Void) {
          if let multipartRequest = request as? MultipartFormDataRequest {
              // Extract the URLRequest
              let urlRequest = try! multipartRequest.asURLRequest()
              
              // Build multipart data using parameters
              AF.upload(
                  multipartFormData: { multipart in
                      for (key, value) in multipartRequest.parameters {
                          if let data = "\(value)".data(using: .utf8) {
                              multipart.append(data, withName: key)
                          }
                      }
                  },
                  to: urlRequest.url!,  // Safely unwrap (ensure URL is valid)
                  method: multipartRequest.method,
                  headers: urlRequest.headers
              )
              .responseData { response in
                  completion(response.result.toSwiftResult())
              }
          } else {
              AF.request(request).responseData { response in
                  completion(response.result.toSwiftResult())
              }
          }
      }
    

    /// Executes the specified Network Request. Upon completion, the payload or error will be emitted to the publisher.
    /// Only one value will be emitted and the request cannot be retried.
    ///
    public func responseDataPublisher(for request: URLRequestConvertible)
        -> AnyPublisher<Result<Data, Error>, Never> {
        return Future { promise in
            AF.request(request).responseData { response in
                
                let result = response.result.toSwiftResult()
                promise(.success(result))
            }
        }.eraseToAnyPublisher()
    }
}
// MARK: - Swift.Result Conversion
//
private extension Result where Failure == AFError {
    /// Convert this `Alamofire.Result` to a `Swift.Result`.
    ///
    func toSwiftResult() -> Swift.Result<Success, Error> {
        switch self {
        case let .success(value):
            return .success(value)
        case let .failure(error):
            return .failure(error)
        }
    }
}
