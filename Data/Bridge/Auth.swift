//
//  AuthService.swift
//  homework
//
//  Created by Alex Rouse on 4/7/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import PromiseKit
import Foundation

protocol Auth {
    func token() -> Promise<String>
}

enum AuthError: Error {
    case invalidToken
}

class DemoAuthClient: Auth { }

