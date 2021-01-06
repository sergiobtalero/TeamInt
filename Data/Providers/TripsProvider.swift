import Domain

public final class TripsProvider {
    public init() {}
}

extension TripsProvider: TripsProviderContract {
    public func getTripsList(completion: @escaping(_: [Trip]?) -> Void) {
        DemoAuthClient().token { token in
            guard let token = token else {
                return
            }
            
            TripsService.list(token: token ).execute { (result: Result<WelcomeEntity?, Error>) in
                switch result {
                case let .success(response):
                    let trips = try? response?.data.driver.loads.trips.toDomain()
                    completion(trips)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
