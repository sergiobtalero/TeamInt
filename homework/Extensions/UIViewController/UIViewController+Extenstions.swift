//
//  UIViewController+Extenstions.swift
//  homework
//
//  Created by Sergio David Bravo Talero on 12/01/21.
//  Copyright © 2021 Indigo. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    func instantiate<T: UIViewController>() -> T {
        guard let identifier = NSStringFromClass(T.self).components(separatedBy: ".").last,
              let vc = self.instantiateViewController(identifier: identifier) as? T else {
            fatalError("Could not load view controller")
        }
        return vc
    }
}
