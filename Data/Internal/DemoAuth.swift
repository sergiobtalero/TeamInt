//
//  DemoAuth.swift
//  homework
//
//  Created by Alex Rouse on 4/7/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import PromiseKit
import Foundation
import Auth0

extension DemoAuthClient {

    var clientId: String    { return "za6TP5NcPzU4RS7ioSVM4O51aDl1y0Oy" }
    var domain: String      { return "indigoag-staging.auth0.com" }
    var scopes: String      { return "offline_access" }
    var realm: String       { return "Username-Password-Authentication" }

    var username: String    { return "evaluations+ios@indigoag.org" }
    var password: String    { return "qarTun-wibkyj-ryzvu0" }

    var audience: String    { return "https://\(domain)/userinfo" }
    
    var mockToken: String {
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik56WTRRVFZFTmprM01EWTNNems1UVRBMlFqZEJOemRGTXpsRE5rUTNOVVZDTkVVMVFrUXdPUSJ9.eyJuaWNrbmFtZSI6ImV2YWx1YXRpb25zK2lvcyIsIm5hbWUiOiJldmFsdWF0aW9ucytpb3NAaW5kaWdvYWcub3JnIiwicGljdHVyZSI6Imh0dHBzOi8vcy5ncmF2YXRhci5jb20vYXZhdGFyL2U4YzlhOTI2MDRkM2I2NGNkODQ3YTA1ZDY3OTM1OThmP3M9NDgwJnI9cGcmZD1odHRwcyUzQSUyRiUyRmNkbi5hdXRoMC5jb20lMkZhdmF0YXJzJTJGZXYucG5nIiwidXBkYXRlZF9hdCI6IjIwMjEtMDEtMDVUMTk6Mjg6NDkuMTQ4WiIsImVtYWlsIjoiZXZhbHVhdGlvbnMraW9zQGluZGlnb2FnLm9yZyIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJpc3MiOiJodHRwczovL2luZGlnb2FnLXN0YWdpbmcuYXV0aDAuY29tLyIsInN1YiI6ImF1dGgwfDVlZmY2OWZiYzhhYTdmMDAxMzUxNzJhNCIsImF1ZCI6InphNlRQNU5jUHpVNFJTN2lvU1ZNNE81MWFEbDF5ME95IiwiaWF0IjoxNjA5ODc0OTI5LCJleHAiOjE2MDk5NjEzMjl9.X_5SsOCmJkDIMeJCwL45iKgOj6gASGNg6cSmTwvpRRkfVHE8lD7ZDf0Bw4OfaS5-nbhsINVh5dXtax9XFu39i35kvu8CKTxxjfAVvi_HrkDD_2wFId2PxSRpPxEVcrSdLMG1jX_RKB5EV1rjLE4j9vBHW2K3X7jCMHAAOUFc2pNx7BiszscJ7ty8bXBmEzYiCL9-pgv4ZcS6jxqbFrzAVBqshyJ-dzOsQnks1EbWl8v6HFnrxt7jmzcmudZR6q7GjOVK-1CvIGNsEjHkG95QB60_P0DOnXikekvwDLn-Bwg3J1E6NB7_Or9VHl3rslHsHZiQV5zheO7ieXsRTwWQFA"
    }

    func login(email: String, password: String, then completion: @escaping (String?) -> Void) {

        Auth0.authentication(clientId: clientId, domain: domain).login(usernameOrEmail: email,
                             password: password,
                             realm: realm,
                             audience: audience,
                             scope: scopes,
                             parameters: nil).start { result in
                                switch result {
                                case .failure(let error):
                                    print("Error authenticating.  Contact Indigo, this shouldn't happen: \(error)")
//                                    completion(nil)
                                    completion(self.mockToken)
                                case .success(let creds):
                                    completion(creds.idToken)
                                }
        }
        
    }
}

extension DemoAuthClient {

    func token() -> Promise<String> {
        Promise { seal in
            login(email: username, password: password) { token in
                if let token = token {
                    seal.fulfill(token)
                } else {
                    seal.reject(AuthError.invalidToken)
                }
            }
        }
    }
}
