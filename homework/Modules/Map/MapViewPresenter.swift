//
//  MapViewPresenter.swift
//  homework
//
//  Created by Sergio David Bravo Talero on 13/01/21.
//  Copyright © 2021 Indigo. All rights reserved.
//

import Foundation
import MapKit
import Domain

final class MapPresenter {
    private weak var view: MapViewContract?
    private let fromCoordinates: TripCoordinates
    private let toCoordinates: TripCoordinates
    
    init(view: MapViewContract,
         fromCoordinates: TripCoordinates,
         toCoordinates: TripCoordinates) {
        self.view = view
        self.fromCoordinates = fromCoordinates
        self.toCoordinates = toCoordinates
    }
}

extension MapPresenter: MapContract.Presenter {
    func viewDidLoad() {
        let request = MKDirections.Request()
        
        let fromPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: fromCoordinates.latitude,
                                                                           longitude: fromCoordinates.longitude))
        let toPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: toCoordinates.latitude,
                                                                         longitude: toCoordinates.longitude))
        request.source = MKMapItem(placemark: fromPlacemark)
        request.destination = MKMapItem(placemark: toPlaceMark)
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] (response, error) in
            response?.routes.first.map { self?.view?.renderRoute($0) }
        }
    }
    
}
