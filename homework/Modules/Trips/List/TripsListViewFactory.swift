//
//  TripsListViewFactory.swift
//  homework
//
//  Created by Sergio David Bravo Talero on 13/01/21.
//  Copyright © 2021 Indigo. All rights reserved.
//

import Foundation
import Injector
import UIKit

final class TripsListViewFactory: VCFactoryContract {
    static func makeViewControlller(dependencies: VCDependencies? = nil) -> TripsListViewController {
        let vc: TripsListViewController = UIStoryboard(name: "TripsList", bundle: Bundle.main).instantiate()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
           let coordinator = appDelegate.coordinator {
            vc.presenter = TripsListPresenter(view: vc,
                                              getTripsListUseCase: Injector.provideGetTripsListUseCase(),
                                              getTripsListMockedUseCase: Injector.provideGetTripsListMockedUseCase(),
                                              coordinator: coordinator)
        } else {
            fatalError("Could not load app coordinator")
        }
        
        return vc
    }
}
