import Domain

final class TripsListPresenter {
    private weak var view: TripsListViewContract?
    private let getTripsListUseCase: GetTripsListUseCaseContract
    private var getTripsListMockedUseCase: GetTripsListMockedUseCaseContract?
    
    var trips: [Trip] = []
    
    public init(view: TripsListViewContract?,
                getTripsListUseCase: GetTripsListUseCaseContract,
                getTripsListMockedUseCase: GetTripsListMockedUseCaseContract?) {
        self.view = view
        self.getTripsListUseCase = getTripsListUseCase
        self.getTripsListMockedUseCase = getTripsListMockedUseCase
    }
}

// MARK: - TripsListPresenterContract
extension TripsListPresenter: TripsListPresenterContract {
    func fetchData() {
        getTripsListUseCase.execute()
            .done({ trips in
                self.trips = trips
                self.view?.renderTrips(trips.map { TripTableViewModel(trip: $0) })
            }).catch { _ in
                self.mockData()
//                self.view?.showError()
            }
    }
}

// MARK: - Private Methods
private extension TripsListPresenter {
    // WARNING:
    // During development, the Auth service kept failing, so development had to continue with mocking response
    func mockData() {
        if let trips = getTripsListMockedUseCase?.execute() {
            view?.renderTrips(trips.map { TripTableViewModel(trip: $0) })
        } else {
            view?.showError()
        }
    }
}
