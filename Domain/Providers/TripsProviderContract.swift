import PromiseKit

public protocol TripsProviderContract {
    func getTripsList(completion: @escaping(_: [Trip]?) -> Void)
}
