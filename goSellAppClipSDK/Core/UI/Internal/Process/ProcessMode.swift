//
//  ProcessMode.swift
//  goSellSDK
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

internal protocol ProcessMode {}
internal protocol Payment: ProcessMode {}
internal protocol CardSaving: ProcessMode {}
internal protocol CardTokenization: ProcessMode {}

import UIKit

internal class ProcessModeClass: ProcessMode {}

import UIKit

internal class PaymentClass:			ProcessModeClass, Payment {}
import UIKit

internal class CardSavingClass:			ProcessModeClass, CardSaving {}
import UIKit

internal class CardTokenizationClass:	ProcessModeClass, CardTokenization {}
