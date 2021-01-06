import Foundation

public final class MockURLSession: URLSession {
    var url: URL?
    var request: URLRequest?
    private let dataTask: MockURLSessionDataTask
    
    public init(data: Data?, response: URLResponse?, error: Error?) {
        dataTask = MockURLSessionDataTask()
        dataTask.taskResponse = (data, response, error)
    }
    
    public override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = url
        self.dataTask.completionHandler = completionHandler
        return self.dataTask
    }
    
    public override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        self.dataTask.completionHandler = completionHandler
        return self.dataTask
    }
    
    
}

public final class MockURLSessionDataTask: URLSessionDataTask {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?
    var taskResponse: (Data?, URLResponse?, Error?)?
    
    public override init() {}
    
    public override func resume() {
        completionHandler?(taskResponse?.0, taskResponse?.1, taskResponse?.2)
    }
}
