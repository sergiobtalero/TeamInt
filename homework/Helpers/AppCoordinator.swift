//
//  AppCoordinator.swift
//  
//
//  Created by Sergio David Bravo Talero on 13/01/21.
//

import Foundation
import Domain
import UIKit

enum AppRoutes {
    case tripsList
    case tripsMap(from: TripCoordinates, to: TripCoordinates)
}

extension AppRoutes: Equatable {
    static func ==(lhs: AppRoutes, rhs: AppRoutes) -> Bool {
        switch (lhs, rhs) {
        case (.tripsList,   .tripsList):
            return true
        case let (.tripsMap(from: fromA, to: toA), .tripsMap(from: fromB, to: toB)):
            return fromA.latitude == fromB.latitude &&
                fromA.longitude == fromB.longitude &&
                toA.latitude == toB.latitude &&
                toA.longitude == toB.longitude
        default:
            return false
        }
    }
}

protocol AppCoordinatorContract: Coordinator {
    func prepareTransition(for route: AppRoutes)
}

final class AppCoordinator: AppCoordinatorContract {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = TripsListViewFactory.makeViewControlller()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func prepareTransition(for route: AppRoutes) {
        switch route {
        case .tripsList:
            let vc = TripsListViewFactory.makeViewControlller()
            navigationController.pushViewController(vc, animated: true)
        case let .tripsMap(from, to):
            let mapDependencies = MapDependencies(fromCoordinates: from,
                                                  toCoordinates: to)
            let vc = MapViewFactory.makeViewControlller(dependencies: mapDependencies)
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
