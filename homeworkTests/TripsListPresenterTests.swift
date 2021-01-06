@testable import homework
@testable import Data
import PromiseKit
import Domain
import XCTest

class TripsListPresenterTests: XCTestCase {
    func testFetchData() {
        // GIVEN
        let exp = expectation(description: "Render trips")
        let view = TripsListViewMock()
        let getTripListUseCaseMock = GetTripsListUseCaseMock(trips: getTripsFromLocalFile(),
                                                         error: nil)
        let presenter = TripsListPresenter(view: view,
                                           getTripsListUseCase: getTripListUseCaseMock,
                                           getTripsListMockedUseCase: nil)
        
        // WHEN
        presenter.fetchData()
        
        // THEN
        let state = XCTWaiter.wait(for: [exp], timeout: 3)
        if state == XCTWaiter.Result.timedOut {
            XCTAssert(!view.tripsViewModels.isEmpty)
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
        let presenter = TripsListPresenter(view: view,
                                           getTripsListUseCase: getTripListUseCaseMock,
                                           getTripsListMockedUseCase: nil)
        
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
