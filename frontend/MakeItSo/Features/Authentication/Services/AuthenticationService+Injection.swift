//
//  AuthenticationService+Injection.swift
//  MakeItSo
//
//  Created by madeinweb on 29/07/23.
//

import Foundation
import Factory


extension Container {
  public var authenticationService: Factory<AuthenticationService> {
    self {
      AuthenticationService()
    }.singleton
  }
}
