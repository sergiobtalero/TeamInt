import PromiseKit
import Domain

final class TripsProviderMock {
    var trips: [Trip]?
    var error: TripsProviderError?
    
    // MARK: - Conveniance Init
    init(trips: [Trip]?, error: TripsProviderError?) {
        self.error = error
        self.trips = trips
    }
    
    convenience init(trips: [Trip]) {
        self.init(trips: trips, error: nil)
    }
    
    convenience init(error: TripsProviderError) {
        self.init(trips: nil, error: error)
    }
}

// MARK: - TripsProviderContract
extension TripsProviderMock: TripsProviderContract {
    func getTripsListMocked() -> [Trip] {
        return trips ?? []
    }
    
    func getTripsList() -> Promise<[Trip]> {
        return Promise { seal in
            if let trips = trips {
                seal.fulfill(trips)
            } else if let error = error {
                seal.reject(error)
            }
        }
    }
}
