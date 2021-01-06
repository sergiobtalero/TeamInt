@testable import homework

final class TripsListViewMock: TripsListViewContract {
    var tripsViewModels: [TripTableViewModel] = []
    var shouldShowError: Bool = false
    
    func renderTrips(_ tripsViewModels: [TripTableViewModel]) {
        self.tripsViewModels = tripsViewModels
    }
    
    func showError() {
        shouldShowError = true
    }
}
