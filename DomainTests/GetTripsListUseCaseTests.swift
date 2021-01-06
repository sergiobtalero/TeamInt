@testable import Domain
@testable import Data
import XCTest

class GetTripsListUseCaseTests: XCTestCase {
    func testGetTripsListUseCaseSuccess() {
        // GIVEN
        let expectation = XCTestExpectation(description: "Retrieve list of trips")
        let provider = TripsProviderMock(trips: getTripsFromLocalFile())
        let useCase = GetTripsListUseCase(provider: provider)
        
        // THEN
        useCase.execute()
            .done({ trips in
                XCTAssertEqual(trips.first?.id, "o8GWEiDXNP")
            })
            .ensure ({
                expectation.fulfill()
            }).catch { _ in
                XCTFail("Unexpected error")
            }
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testsGetTripsListUseCaseGenericError() {
        // GIVEN
        let expectation = XCTestExpectation(description: "Retrieve list of trips")
        let provider = TripsProviderMock(error: .generic)
        let useCase = GetTripsListUseCase(provider: provider)
        
        // THEN
        useCase.execute()
            .done({ trips in
                XCTFail("Unexpected respoonse")
            })
            .ensure ({
                expectation.fulfill()
            }).catch { error in
                if let error = error as? GetTripsListUseCaseError {
                    XCTAssertEqual(error, .generic)
                } else {
                    XCTFail("Unexpected error")
                }
            }
        wait(for: [expectation], timeout: 0.5)
    }
}

private extension GetTripsListUseCaseTests {
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
