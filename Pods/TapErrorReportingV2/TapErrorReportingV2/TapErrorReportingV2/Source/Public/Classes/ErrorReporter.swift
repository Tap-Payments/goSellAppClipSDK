//
//  ErrorReporter.swift
//  TapErrorReporting
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

/// Error reporter.
public final class ErrorReporter {
	
	// MARK: - Public -
	// MARK: Properties
	
	/// Shared error reporter.
	public static let shared: ErrorReporting = ErrorReporterImpl()
	
	// MARK: - Private -
	// MARK: Methods
	
	@available(*, unavailable) private init() { fatalError("This class cannot be instantiated.") }
}
