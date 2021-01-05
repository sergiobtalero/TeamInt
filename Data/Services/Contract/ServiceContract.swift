import Foundation

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
    
    func execute<T: Codable>(session: URLSession,
                             completion: @escaping (Result<T?, Error>) -> Void)
}

extension ServiceContract {
    public func execute<T: Codable>(session: URLSession = URLSession.shared,
                                    completion: @escaping (Result<T?, Error>) -> Void) {
        guard let request = urlRequest else {
            completion(.failure(APINetworkError.invalidRequest))
            return
        }
        
        let task = session.dataTask(with: request) { (data, _, error) in
            if error != nil {
                completion(.failure(APINetworkError.badResponse))
                return
            }
            guard let data = data else {
                completion(.failure(APINetworkError.invalidData))
                return
            }
            let objects = try? JSONDecoder().decode(T.self, from: data)
            completion(.success(objects))
        }
        task.resume()
    }
}
