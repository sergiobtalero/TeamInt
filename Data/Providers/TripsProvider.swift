public final class TripsProvider {
    public init() {}
}

extension TripsProvider {
    public func getTripsList() {
        DemoAuthClient().token { token in
            guard let token = token else {
                return
            }
            TripsService.list(token: token ).execute { (result: Result<Welcome?, Error>) in
                switch result {
                case let .success(response):
                    print(response)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
