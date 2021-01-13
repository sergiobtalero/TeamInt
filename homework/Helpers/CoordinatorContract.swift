//
//  CoordinatorContract.swift
//  homework
//
//  Created by Sergio David Bravo Talero on 13/01/21.
//  Copyright © 2021 Indigo. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    init(navigationController: UINavigationController)
    func start()
}
