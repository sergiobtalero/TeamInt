public protocol GetTripsListMockedUseCaseContract {
    func execute() -> [Trip]
}

public final class GetTripsListMockedUseCase {
    private let provider: TripsProviderContract
    
    public init(provider: TripsProviderContract) {
        self.provider = provider
    }
}

// MARK: - GetTripsListUseCaseContract
extension GetTripsListMockedUseCase: GetTripsListMockedUseCaseContract {
    public func execute() -> [Trip] {
        provider.getTripsListMocked()
    }
}

