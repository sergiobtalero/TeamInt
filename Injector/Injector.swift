import Domain
import Data

public final class Injector {
    public static func provideGetTripsListUseCase() -> GetTripsListUseCaseContract {
        return GetTripsListUseCase(provider: provideTripProvider())
    }
    
    public static func provideGetTripsListMockedUseCase() -> GetTripsListMockedUseCaseContract {
        return GetTripsListMockedUseCase(provider: provideTripProvider())
    }
}

// MARK: - Private Injector Methods
private extension Injector {
    static func provideTripProvider() -> TripsProviderContract {
        return TripsProvider()
    }
}
