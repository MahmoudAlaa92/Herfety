//
//  AlertModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 19/02/2025.
//

import UIKit

typealias ActionHandler = () -> Void

public struct AlertModel {
    let message: String
    let buttonTitle: String
    let image: AlertStatus
    let status: AlertStatus
    var buttonAction: ActionHandler?
}
