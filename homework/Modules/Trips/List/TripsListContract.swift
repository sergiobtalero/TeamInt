import Domain

protocol TripsListContract {
    typealias View = TripsListViewContract
    typealias Presenter = TripsListPresenterContract
}

protocol TripsListViewContract: AnyObject {
    func renderTrips(_ tripsViewModels: [TripTableViewModel])
    func showError()
}

protocol TripsListPresenterContract {
    func fetchData()
}
