@testable import Data
import Domain
import XCTest

class TripsTests: XCTestCase {
    func testWelcomeEntityParserSuccess() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Trips", withExtension: "json") else {
            XCTFail("Could not load json file")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(WelcomeEntity.self, from: data)
            XCTAssertEqual(response.data.driver.typename, "Driver")
            XCTAssertEqual(response.data.driver.loads.trips.first?.id, "o8GWEiDXNP")
        } catch {
            XCTFail("Could not decode PokedexEntity")
        }
        XCTAssert(true)
    }
    
    func testGetTripsListSuccess() {
        // GIVEN
        let expectation = XCTestExpectation(description: "Retrieve list of trips")
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Trips", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("Could not load data")
            return
        }
        let urlSession = MockURLSession(data: data, response: nil, error: nil)

        // THEN
        TripsService.list(token: "token").execute(session: urlSession, object: WelcomeEntity.self)
            .done ({ welcomeEntity in
                let welcomeModel = try? welcomeEntity.toDomain()
                XCTAssertEqual(welcomeModel?.data?.driver?.loads?.trips?.first?.typename, "TruckingTrip")
            })
            .ensure ({
                expectation.fulfill()
            })
            .catch({ _ in
                XCTFail("Could not load trips")
            })

        wait(for: [expectation], timeout: 0.5)
    }

    func testGetTripsListBadRessponse() {
        // GIVEN
        let expectation = XCTestExpectation(description: "Error fetching trips")
        let urlSession = MockURLSession(data: nil, response: nil, error: APINetworkError.badResponse)

        // THEN
        TripsService.list(token: "token").execute(session: urlSession, object: WelcomeEntity.self)
            .done({ _ in
                XCTFail("Unexpected answer")
            })
            .ensure ({
                expectation.fulfill()
            })
            .catch({ error in
                if let error = error as? APINetworkError {
                    XCTAssertEqual(error, .badResponse)
                } else {
                    XCTFail("Unexpected error")
                }
            })
        wait(for: [expectation], timeout: 0.5)
    }
}
