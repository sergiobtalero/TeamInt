public protocol TripsProviderContract {
    func getTripsList(completion: @escaping(_: [Trip]?) -> Void)
}
