//
//  GDConstants.swift
//  Goods
//
//  Created by nabanita on 30/04/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
enum GDErrorAlertMessage {
    static let emptyMobile = "Please enter mobile"
    static let emptyPassword = "Please enter password"
    static let emptyOldPassword = "Please enter your old password"
    static let emptyNewPassword = "Please enter new password"
    static let emptyConfirmPassword = "Please confirm your new password"
    static let mismatchPassword = "The entered passwords do not match. Please check again."
    static let emptyEmail = "Please enter email"
    static let invalidEmail = "Please enter a valid email"
    static let emptyName = "Please enter name"
    static let emptyCountryCode = "Please enter country code"
    static let emptyCart = "Please add at least one item to your cart to place an order"
}

enum GDMessage {
    static let selectCountry = "Choose Country"
    static let registrationSuccess = "Registration successful"
    static let logoutSuccess = "You are successfully logged out of Goods"
    static let guestUser = "Guest user"
    static let updationSuccess = "Update succeeded"
    static let orderPlaced = "Your order is placed successfully!"
}

class Global {
    var destinationViewType = DestinationViewType.dashboard
}

let global = Global()

