//
//  Constants.swift
//  CodeOrganizer
//
//  Created by mitul jindal on 10/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import Foundation

extension GitHubClient {
    
    enum AuthValues {
        static let authURL = "https://github.com/login/oauth/authorize"
        static let clientID = "149e5e8d655d7b09f216"
        static let clientSecret = "0d74cc84423eb142ab7dcf175fa5c85c9c5b22e0"
        static let redirectURL = "https://github-onthego.firebaseapp.com/__/auth/handler"
        static let state = "hakunaMatata"
        static let allowSignUp = "true"
    }

    enum AuthKeys {
        static let clientID = "client_id"
        static let redirectURL = "redirect_uri"
        static let state = "state"
        static let allowSignUp = "allow_signup"
    }
    
    enum API {
        static let url = "https://api.github.com"
        static let userReps = "/user/repos"
        static let starredReps = "/user/starred"
    }
}
