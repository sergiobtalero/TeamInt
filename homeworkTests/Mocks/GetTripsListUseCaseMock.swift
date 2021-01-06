@testable import homework
import PromiseKit
import Domain

final class GetTripsListUseCaseMock: GetTripsListUseCaseContract {
    var trips: [Trip] = []
    var error: Error?
    
    init(trips: [Trip], error: Error?) {
        self.trips = trips
        self.error = error
    }
    
    func execute() -> Promise<[Trip]> {
        if let error = error {
            return .init(error: error)
        } else {
            return .value(trips)
        }
    }
}
