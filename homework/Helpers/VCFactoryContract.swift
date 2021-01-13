//
//  VCFactoryContract.swift
//  homework
//
//  Created by Sergio David Bravo Talero on 13/01/21.
//  Copyright © 2021 Indigo. All rights reserved.
//

import Foundation

protocol VCFactoryContract {
    associatedtype VC
    static func makeViewControlller() -> VC
}
