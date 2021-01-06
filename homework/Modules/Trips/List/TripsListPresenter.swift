import Domain

final class TripsListPresenter {
    private weak var view: TripsListViewContract?
    private let getTripsListUseCase: GetTripsListUseCaseContract
    
    private var trips: [Trip] = []
    
    public init(view: TripsListViewContract?,
                getTripsListUseCase: GetTripsListUseCaseContract) {
        self.view = view
        self.getTripsListUseCase = getTripsListUseCase
    }
}

// MARK: - TripsListPresenterContract
extension TripsListPresenter: TripsListPresenterContract {
    func fetchData() {
        getTripsListUseCase.execute()
            .done({ trips in
                    self.view?.renderTrips(trips.map { TripTableViewModel(trip: $0) })
            }).catch { _ in
                self.view?.showError()
            }
    }
}
