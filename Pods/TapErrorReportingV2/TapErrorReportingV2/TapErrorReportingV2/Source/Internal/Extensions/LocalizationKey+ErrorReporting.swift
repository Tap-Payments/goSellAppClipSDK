//
//  LocalizationKey+ErrorReporting.swift
//  TapErrorReporting
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import struct	TapBundleLocalization.LocalizationKey

internal extension LocalizationKey {
	
	// MARK: - Internal -
	// MARK: Properties
	
	static let alert_report_error_title			= LocalizationKey("alert_report_error_title")
	static let alert_report_error_message			= LocalizationKey("alert_report_error_message")
	static let alert_report_error_dont_ask_again	= LocalizationKey("alert_report_error_dont_ask_again")
	static let alert_report_error_btn_allow		= LocalizationKey("alert_report_error_btn_allow")
	static let alert_report_error_btn_dont_allow	= LocalizationKey("alert_report_error_btn_dont_allow")
	
	static let alert_report_error_success_title		= LocalizationKey("alert_report_error_success_title")
	static let alert_report_error_success_message		= LocalizationKey("alert_report_error_success_message")
	static let alert_report_error_success_btn_dismiss	= LocalizationKey("alert_report_error_success_btn_dismiss")
}
