//
//  MapViewFactory.swift
//  homework
//
//  Created by Sergio David Bravo Talero on 13/01/21.
//  Copyright © 2021 Indigo. All rights reserved.
//

import Foundation
import Domain
import UIKit

final class MapViewFactory: VCFactoryContract {
    static func makeViewControlller(dependencies: VCDependencies?) -> MapViewController {
        let vc: MapViewController = UIStoryboard(name: "Map", bundle: Bundle.main).instantiate()
        if let dependencies = dependencies as? MapDependencies {
            vc.presenter = MapPresenter(fromCoordinates: dependencies.fromCoordinates,
                                        toCoordinates: dependencies.toCoordinates)
        } else {
            fatalError("Must provide view dependencies")
        }
        
        return vc
    }
}

struct MapDependencies: VCDependencies {
    let fromCoordinates: TripCoordinates
    let toCoordinates: TripCoordinates
}
