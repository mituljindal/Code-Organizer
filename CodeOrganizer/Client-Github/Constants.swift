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
        static let clientID = "533cf4d79f5d2dc0b5c4"
        static let clientSecret = "d8af8c5ade15e7deb85186d103c47ff127ce33d8"
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
