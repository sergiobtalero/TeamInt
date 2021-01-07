@testable import homework

final class TripsListViewMock: TripsListViewContract {
    var shouldShowError: Bool = false
    var orderedTripsByDistanceViewModels: [TripTableViewModel] = []
    var orderedTripsByIDViewModels: [TripTableViewModel] = []
    
    
    func renderTrips(orderedByDistance: [TripTableViewModel], orderedByID: [TripTableViewModel]) {
        orderedTripsByDistanceViewModels = orderedByDistance
        orderedTripsByIDViewModels = orderedByID
    }
    
    func showError() {
        shouldShowError = true
    }
}
