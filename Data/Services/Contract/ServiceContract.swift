import Foundation
import PromiseKit

typealias URLSessionResponse = (Data?, URLResponse?, Error?) -> Void

public enum APINetworkError: Error {
    case invalidURL
    case badResponse
    case invalidData
    case invalidRequest
}

@frozen
public enum Result<Success, Failure: Error> {
  case success(Success)
  case failure(Failure)
}

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol ServiceContract {
    var baseURL: String { get }
    var urlRequest: URLRequest? { get }
    var httpBody: Data? { get }
    var headers: [String: String]? { get }
    var httpMethod:HttpMethod { get }
    
    func execute<T: Codable>(session: URLSession) -> Promise<T?>
}

extension ServiceContract {
    func execute<T: Codable>(session: URLSession) -> Promise<T?> {
        Promise { seal in
            guard let request = self.urlRequest else {
                seal.reject(APINetworkError.invalidRequest)
                return
            }
            
            let task = session.dataTask(with: request) { (data, _, error) in
                if error != nil {
                    seal.reject(APINetworkError.badResponse)
                    return
                }
                guard let data = data else {
                    seal.reject(APINetworkError.invalidData)
                    return
                }
                let objects = try? JSONDecoder().decode(T.self, from: data)
                seal.fulfill(objects)
            }
            task.resume()
        }
    }
}
