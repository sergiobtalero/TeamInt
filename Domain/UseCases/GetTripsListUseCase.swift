import PromiseKit

public protocol GetTripsListUseCaseContract {
    func execute() -> Promise<[Trip]>
}

public enum GetTripsListUseCaseError: Error {
    case generic
}

public final class GetTripsListUseCase {
    private let provider: TripsProviderContract
    
    public init(provider: TripsProviderContract) {
        self.provider = provider
    }
}

// MARK: - GetTripsListUseCaseContract
extension GetTripsListUseCase: GetTripsListUseCaseContract {
    public func execute() -> Promise<[Trip]> {
        return provider.getTripsList()
            .recover ({ _ -> Promise<[Trip]> in
                throw GetTripsListUseCaseError.generic
            })
    }
}

