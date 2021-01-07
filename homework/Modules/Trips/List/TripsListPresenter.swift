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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            
            let scheduledDelivery = trip.scheduledDeliveryOn.map { dateFormatter.string(from: $0) } ?? ""
            let deliveredOnDate = trip.deliveredAt.map { dateFormatter.string(from: $0) } ?? ""
            
            return TripTableViewModel(tripName: trip.typename,
                                      id: trip.id,
                                      deliveryStatus: trip.deliveryStatus,
                                      scheduledDelivery: scheduledDelivery,
                                      deliveredOnDate: deliveredOnDate)
        }
    }
    
    func generateViewModels(with trips: [Trip]) {
        let tripsSortedByID = trips.sorted(by: { $0.id < $1.id })
        let tripsSortedByTypename = trips.sorted(by: { $0.typename < $1.typename })
        view?.renderTrips(orderedByName: getTripsViewModels(from: tripsSortedByTypename),
                          orderedByID: getTripsViewModels(from: tripsSortedByID))
    }
}
