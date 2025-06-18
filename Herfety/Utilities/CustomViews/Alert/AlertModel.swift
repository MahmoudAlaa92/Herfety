//
//  AlertModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 19/02/2025.
//

import UIKit

typealias ActionHandler = () -> Void

public struct AlertModel {
    var message: String
    let buttonTitle: String
    var image: AlertStatus
    var status: AlertStatus
    var buttonAction: ActionHandler?
}
