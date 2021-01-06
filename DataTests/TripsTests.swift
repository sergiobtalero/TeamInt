@testable import Data
@testable import Domain
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
    
//    func testGetTripsListSuccess() {
//        // GIVEN
//        let expectation = XCTestExpectation(description: "Retrieve list of trips")
//        let bundle = Bundle(for: type(of: self))
//        guard let url = bundle.url(forResource: "Trips", withExtension: "json"),
//              let data = try? Data(contentsOf: url) else {
//            XCTFail("Could not load data")
//            return
//        }
//        let urlSession = MockURLSession(data: data, response: nil, error: nil)
//
//        // THEN
////        PokedexService.list.execute(session: urlSession) { (result: Result<RawServerResponse<RawEntity>?, Error>) in
////            if case let (.success(response)) = result,
////               let pokedexes = response?.results {
////                XCTAssertEqual(pokedexes.first!.name, "national")
////                XCTAssertEqual(pokedexes.first!.url, "https://pokeapi.co/api/v2/pokedex/1/")
////            } else {
////                XCTFail("Could not retrieve list of pokedexes")
////            }
////            expectation.fulfill()
////        }
//        TripsService.list(token: "token").execute(session: urlSession, object: WelcomeEntity.self)
//            .done ({ welcomeEntity in
//                let welcomeModel = try? welcomeEntity.toDomain()
//                XCTAssertEqual(welcomeModel?.data?.driver?.loads?.trips?.first?.typename, "TruckingTrip")
//                expectation.fulfill()
//            }).catch({ _ in
//                XCTFail("Could not load trips")
//                expectation.fulfill()
//            })
////        TripsService.list(session: urlSession, token: "token").execute(object: WelcomeEntity.self)
////            .done ({ welcomeEntity in
////                let welcomeModel = try? welcomeEntity.toDomain()
////                XCTAssertEqual(welcomeModel?.data?.driver?.loads?.trips?.first?.typename, "TruckingTrip")
////            }).catch({ _ in
////                XCTFail("Could not load trips")
////            })
//
//        wait(for: [expectation], timeout: 0.5)
//    }
//
//    func testGetListOfPokedexesFail() {
//        // GIVEN
//        let expectation = XCTestExpectation(description: "Error fetching pokedexes")
//        let urlSession = MockURLSession(data: nil, response: nil, error: APINetworkError.badResponse)
//
//        // THEN
//        PokedexService.list.execute(session: urlSession) { (result: Result<RawServerResponse<RawEntity>?, Error>) in
//            if case let(.failure(error)) = result,
//               let err = error as? APINetworkError {
//                XCTAssertEqual(err, .badResponse)
//            } else {
//                XCTFail("Invalid error or response")
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.5)
//    }
}
