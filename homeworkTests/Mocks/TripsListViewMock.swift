@testable import homework

final class TripsListViewMock: TripsListViewContract {
    var shouldShowError: Bool = false
    var orderedTripsByNameViewModels: [TripTableViewModel] = []
    var orderedTripsByIDViewModels: [TripTableViewModel] = []
    
    
    func renderTrips(orderedByName: [TripTableViewModel], orderedByID: [TripTableViewModel]) {
        orderedTripsByNameViewModels = orderedByName
        orderedTripsByIDViewModels = orderedByID
    }
    
    func showError() {
        shouldShowError = true
    }
}
