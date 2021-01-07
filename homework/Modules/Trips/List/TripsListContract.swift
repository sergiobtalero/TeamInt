import Domain

protocol TripsListContract {
    typealias View = TripsListViewContract
    typealias Presenter = TripsListPresenterContract
}

protocol TripsListViewContract: AnyObject {
    func renderTrips(orderedByName: [TripTableViewModel], orderedByID: [TripTableViewModel])
    func showError()
}

protocol TripsListPresenterContract {
    func fetchData()
}
