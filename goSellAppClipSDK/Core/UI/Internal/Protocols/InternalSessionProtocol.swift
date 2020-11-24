//
//  InternalSessionProtocol.swift
//  goSellSDK
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

internal protocol InternalSessionProtocol: SessionProtocol {
	
	var externalSession: SessionProtocol { get }
}
