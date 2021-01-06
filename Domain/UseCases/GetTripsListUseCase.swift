public protocol GetTripsListUseCaseContract {
    func execute(completion: @escaping(_: [Trip]?) -> Void)
}

public final class GetTripsListUseCase {
    private let provider: TripsProviderContract
    
    public init(provider: TripsProviderContract) {
        self.provider = provider
    }
}

extension GetTripsListUseCase: GetTripsListUseCaseContract {
    public func execute(completion: @escaping ([Trip]?) -> Void) {
        provider.getTripsList { trips in
            if let trips = trips {
                completion(trips)
            }
        }
    }
}

