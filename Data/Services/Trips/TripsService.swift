import Foundation

enum TripsService {
    case list(token: String)
}

extension TripsService: ServiceContract {    
    var baseURL: String {
        Constants.apiURL.absoluteString
    }
    
    var urlRequest: URLRequest? {
        switch self {
        case .list:
            guard let url = URL(string: baseURL) else {
                return nil
            }
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod.rawValue
            
            headers?.forEach {
                request.setValue($0.value, forHTTPHeaderField: $0.key)
            }
            
            httpBody.map { request.httpBody = $0 }
            
            return request
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .list:
            guard let path = Bundle.main.path(forResource: "request_body", ofType: "json") else {
                return nil
            }
            let fileUrl = URL(fileURLWithPath: path)
            return try? Data(contentsOf: fileUrl, options: .mappedIfSafe)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case let .list(token):
            return ["content-type": "application/json",
                    "authorization": "Bearer \(token)"]
        }
    }
    
    var httpMethod:HttpMethod {
        switch self {
        case .list:
            return .post
        }
    }
}
