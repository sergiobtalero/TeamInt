//
//  MapViewPresenterTests.swift
//  homeworkTests
//
//  Created by Sergio David Bravo Talero on 13/01/21.
//  Copyright © 2021 Indigo. All rights reserved.
//
@testable import homework
import XCTest
import MapKit
import Domain

final class MapViewMock: MapViewContract {
    var renderedRoute: MKRoute?
    
    func renderRoute(_ route: MKRoute) {
        renderedRoute = route
    }
}

class MapViewPresenterTests: XCTestCase {
    func testDidRenderRouteSuccess() {
        // GIVEN
        let exp = expectation(description: "Found route between coordinates")
        let fromCoordinates = TripCoordinates(typename: "GeoPoint",
                                              latitude: 34.9774055,
                                              longitude: -90.43559259999999)
        let toCoordinates = TripCoordinates(typename: "GeoPoint",
                                            latitude: 35.8743612,
                                            longitude: -90.5993299)
        let view = MapViewMock()
        let presenter = MapPresenter(view: view,
                                     fromCoordinates: fromCoordinates,
                                     toCoordinates: toCoordinates)
        
        // WHEN
        presenter.viewDidLoad()
        
        // THEN
        let state = XCTWaiter.wait(for: [exp], timeout: 3)
        if state == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(view.renderedRoute)
        } else {
            XCTFail("Route is nil")
        }
    }
}
