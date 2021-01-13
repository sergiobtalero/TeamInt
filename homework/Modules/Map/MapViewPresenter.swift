//
//  MapViewPresenter.swift
//  homework
//
//  Created by Sergio David Bravo Talero on 13/01/21.
//  Copyright © 2021 Indigo. All rights reserved.
//

import Foundation
import Domain

final class MapPresenter {
    private let fromCoordinates: TripCoordinates
    private let toCoordinates: TripCoordinates
    
    init(fromCoordinates: TripCoordinates,
         toCoordinates: TripCoordinates) {
        self.fromCoordinates = fromCoordinates
        self.toCoordinates = toCoordinates
    }
}

extension MapPresenter: MapContract.Presenter {
    
}
