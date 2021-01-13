//
//  MapViewController.swift
//  homework
//
//  Created by Sergio David Bravo Talero on 13/01/21.
//  Copyright © 2021 Indigo. All rights reserved.
//

import MapKit
import Domain
import UIKit

final class MapViewController: UIViewController {
    // MARK: - IBOutlets and Properties
    @IBOutlet private weak var mapView: MKMapView!
    
    var presenter: MapPresenterContract?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
}

// MARK: - Private Methods
private extension MapViewController {
    func setupView() {
        mapView.delegate = self
    }
}

// MARK: - MapViewContract
extension MapViewController: MapViewContract {
    func renderRoute(_ route: MKRoute) {
        mapView.addOverlay(route.polyline)
        mapView.setVisibleMapRect(route.polyline.boundingMapRect,
                                  edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0),
                                  animated: true)
    }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        return renderer
    }
}
