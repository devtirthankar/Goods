//
//  GDConstants.swift
//  Goods
//
//  Created by nabanita on 30/04/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
enum GDErrorAlertMessage {
    static let emptyMobile = "Please enter mobile".translate
    static let emptyPassword = "Please enter password".translate
    static let emptyOldPassword = "Please enter your old password".translate
    static let emptyNewPassword = "Please enter new password".translate
    static let emptyConfirmPassword = "Please confirm your new password".translate
    static let mismatchPassword = "The new password and confirm password do not match. Please check again.".translate
    static let emptyEmail = "Please enter email".translate
    static let invalidEmail = "Please enter a valid email".translate
    static let emptyName = "Please enter name".translate
    static let emptyCountryCode = "Please enter country code".translate
    static let emptyCart = "Please add at least one item to your cart to place an order".translate
}

enum GDMessage {
    static let selectCountry = "Choose Country".translate
    static let selectQuantity = "Choose Quantity".translate
    static let registrationSuccess = "Registration successful".translate
    static let logoutSuccess = "You are successfully logged out of Goods".translate
    static let guestUser = "Guest user".translate
    static let updationSuccess = "Update succeeded".translate
    static let orderPlaced = "Your order is placed successfully!".translate
    static let itemOutOfStock = "Sorry! The item is out of stock at this moment!".translate
    static let productAddedToCart = "Product added to cart".translate
    static let passwordWillBeSent = "Temporary password will be sent to your mobile number".translate
}

class Global {
    var destinationViewType = DestinationViewType.dashboard
}

let global = Global()

