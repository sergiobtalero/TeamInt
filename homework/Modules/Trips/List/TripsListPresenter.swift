import Domain

final class TripsListPresenter {
    private weak var view: TripsListViewContract?
    private let getTripsListUseCase: GetTripsListUseCaseContract
    private var getTripsListMockedUseCase: GetTripsListMockedUseCaseContract?
    private var coordinator: AppCoordinatorContract
    
    var trips: [Trip] = []
    
    public init(view: TripsListViewContract?,
                getTripsListUseCase: GetTripsListUseCaseContract,
                getTripsListMockedUseCase: GetTripsListMockedUseCaseContract?,
                coordinator: AppCoordinatorContract) {
        self.view = view
        self.getTripsListUseCase = getTripsListUseCase
        self.getTripsListMockedUseCase = getTripsListMockedUseCase
        self.coordinator = coordinator
    }
}

// MARK: - TripsListPresenterContract
extension TripsListPresenter: TripsListPresenterContract {
    // TODO: - Remove call to mockData and instead notify view to show error once
    // login is fixed
    func fetchData() {
        getTripsListUseCase.execute()
            .done({ trips in
                self.trips = trips
                self.generateViewModels(with: trips)
            }).catch { _ in
                self.mockData()
//                self.view?.showError()
            }
    }
    
    func didSelectRow(_ row: Int) {
        let trip = trips[row]
        if let fromCoordinates = trip.truckingOrder?.locationFrom?.coordinates,
           let toCoordinates = trip.truckingOrder?.locationTo?.coordinates {
            coordinator.prepareTransition(for: AppRoutes.tripsMap(from: fromCoordinates,
                                                         to: toCoordinates))
        }
    }
}

// MARK: - Private Methods
private extension TripsListPresenter {
    // WARNING: - Should be removed once the login is available again
    func mockData() {
        if let trips = getTripsListMockedUseCase?.execute() {
            self.trips = trips
            self.generateViewModels(with: trips)
        } else {
            view?.showError()
        }
    }
    
    func getTripsViewModels(from trips: [Trip]) -> [TripTableViewModel] {
        return trips.map { trip in
            return TripTableViewModel(tripName: trip.typename,
                                      id: trip.id,
                                      deliveryStatus: trip.deliveryStatus,
                                      distance: trip.truckingOrder?.tripDistanceMiles ?? 0)
        }
    }
    
    func generateViewModels(with trips: [Trip]) {
        let tripsSortedByID = trips.sorted(by: { $0.id < $1.id })
        let tripsSortedByDistance = trips.sorted(by: {
            $0.truckingOrder?.tripDistanceMiles ?? 0.0 < $1.truckingOrder?.tripDistanceMiles ?? 0.0
        })
        view?.renderTrips(orderedByDistance: getTripsViewModels(from: tripsSortedByDistance),
                          orderedByID: getTripsViewModels(from: tripsSortedByID))
    }
}
