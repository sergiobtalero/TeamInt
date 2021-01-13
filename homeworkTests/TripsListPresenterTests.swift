@testable import homework
@testable import Data
import PromiseKit
import Domain
import XCTest

class AppCoordinatorMock: AppCoordinatorContract {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var routePresented: AppRoutes?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func prepareTransition(for route: AppRoutes) {
        routePresented = route
    }

    func start() {
        
    }
    
    
}

class TripsListPresenterTests: XCTestCase {
    func testFetchData() {
        // GIVEN
        let exp = expectation(description: "Render trips")
        let view = TripsListViewMock()
        let getTripListUseCaseMock = GetTripsListUseCaseMock(trips: getTripsFromLocalFile(),
                                                         error: nil)
        let coordinator = AppCoordinatorMock(navigationController: UINavigationController())
        let presenter = TripsListPresenter(view: view,
                                           getTripsListUseCase: getTripListUseCaseMock,
                                           getTripsListMockedUseCase: nil,
                                           coordinator: coordinator)
        
        // WHEN
        presenter.fetchData()
        
        // THEN
        let state = XCTWaiter.wait(for: [exp], timeout: 3)
        if state == XCTWaiter.Result.timedOut {
            XCTAssertEqual(view.orderedTripsByDistanceViewModels.first?.distance, 79.6)
            XCTAssertEqual(view.orderedTripsByIDViewModels.first?.id, "o8GWEiDXNP")
        } else {
            XCTFail("Could not render view")
        }
    }
    
    func testFetchDataWithError() {
        // GIVEN
        let exp = expectation(description: "Render trips with error")
        let view = TripsListViewMock()
        let getTripListUseCaseMock = GetTripsListUseCaseMock(trips: [],
                                                             error: GetTripsListUseCaseError.generic)
        let coordinator = AppCoordinatorMock(navigationController: UINavigationController())
        let presenter = TripsListPresenter(view: view,
                                           getTripsListUseCase: getTripListUseCaseMock,
                                           getTripsListMockedUseCase: nil,
                                           coordinator: coordinator)
        
        // WHEN
        presenter.fetchData()
        
        // THEN
        let state = XCTWaiter.wait(for: [exp], timeout: 3)
        if state == XCTWaiter.Result.timedOut {
            XCTAssertEqual(view.shouldShowError, true)
        } else {
            XCTFail("Did not throw error")
        }
    }
    
    func testShowMapScreenSuccess() {
        // GIVEN
        let view = TripsListViewMock()
        let getTripListUseCaseMock = GetTripsListUseCaseMock(trips: [],
                                                             error: GetTripsListUseCaseError.generic)
        let coordinator = AppCoordinatorMock(navigationController: UINavigationController())
        let presenter = TripsListPresenter(view: view,
                                           getTripsListUseCase: getTripListUseCaseMock,
                                           getTripsListMockedUseCase: nil,
                                           coordinator: coordinator)
        presenter.trips = getTripsFromLocalFile()
        
        // WHEN
        presenter.didSelectRow(0)

        // THEN
        let fromCoordinates = TripCoordinates(typename: "GeoPoint",
                                              latitude: 34.9774055,
                                              longitude: -90.43559259999999)
        let toCoordinates = TripCoordinates(typename: "GeoPoint",
                                            latitude: 35.8743612,
                                            longitude: -90.5993299)
        XCTAssertEqual(coordinator.routePresented, .tripsMap(from: fromCoordinates,
                                                             to: toCoordinates))
    }
}

private extension TripsListPresenterTests {
    func getTripsFromLocalFile() -> [Trip] {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Trips", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let welcomeEntity = try? JSONDecoder().decode(WelcomeEntity.self, from: data),
              let welcomeModel = try? welcomeEntity.toDomain() else {
            fatalError("Could not load file")
        }
        
        return welcomeModel.data?.driver?.loads?.trips ?? []
    }
}
