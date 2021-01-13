//
//  AppCoordinatorTests.swift
//  homeworkTests
//
//  Created by Sergio David Bravo Talero on 13/01/21.
//  Copyright © 2021 Indigo. All rights reserved.
//

@testable import homework
import XCTest
import Domain

class SpyNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
}

class AppCoordinatorTests: XCTestCase {
    func testTransitionToTripsList() {
        // GIVEN
        let navController = SpyNavigationController()
        let coordinator = AppCoordinator(navigationController: navController)
        
        coordinator.prepareTransition(for: .tripsList)
        if let pushedViewController = navController.pushedViewController {
            XCTAssertTrue(pushedViewController.isKind(of: TripsListViewController.self))
        } else {
            XCTFail("Unextected VC")
        }
    }
    
    func testTransitionToTripsMap() {
        // GIVEN
        let navController = SpyNavigationController()
        let coordinator = AppCoordinator(navigationController: navController)
        let fromCoordinates = TripCoordinates(typename: "GeoPoint",
                                              latitude: 34.9774055,
                                              longitude: -90.43559259999999)
        let toCoordinates = TripCoordinates(typename: "GeoPoint",
                                            latitude: 35.8743612,
                                            longitude: -90.5993299)
        // WHEN
        coordinator.prepareTransition(for: .tripsMap(from: fromCoordinates,
                                                     to: toCoordinates))
        
        // THEN
        if let pushedViewController = navController.pushedViewController {
            XCTAssertTrue(pushedViewController.isKind(of: MapViewController.self))
        } else {
            XCTFail("Unextected VC")
        }
    }
}
