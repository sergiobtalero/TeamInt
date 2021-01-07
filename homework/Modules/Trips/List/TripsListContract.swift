import Domain

protocol TripsListContract {
    typealias View = TripsListViewContract
    typealias Presenter = TripsListPresenterContract
}

protocol TripsListViewContract: AnyObject {
    func renderTrips(orderedByDistance: [TripTableViewModel], orderedByID: [TripTableViewModel])
    func showError()
}

protocol TripsListPresenterContract {
    func fetchData()
}
