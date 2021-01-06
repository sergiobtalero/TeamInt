import PromiseKit

public enum TripsProviderError: Error {
    case generic
}

public protocol TripsProviderContract {
    func getTripsList() -> Promise<[Trip]>
}
