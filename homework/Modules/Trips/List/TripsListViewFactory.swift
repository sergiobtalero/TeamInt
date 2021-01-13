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
    static func makeViewControlller() -> TripsListViewController {
        let vc: TripsListViewController = UIStoryboard(name: "TripsList", bundle: Bundle.main).instantiate()
        vc.presenter = TripsListPresenter(view: vc,
                                          getTripsListUseCase: Injector.provideGetTripsListUseCase(),
                                          getTripsListMockedUseCase: Injector.provideGetTripsListMockedUseCase())
        return vc
    }
}
