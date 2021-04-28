//
//  DemoAppConfig.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import SwiftUI

final class DemoAppConfig: ObservableObject {

	// MARK: - Vars

	var vaultId = "VAULT_ID"
	var path = "post"
	let payloadKey = "VGS_TEST_PAYLOAD_KEY"
	let payloadValue = "VGS_TEST_PAYLOAD_VALUE"

	@Published var collectPayload: [String: Any] = [:]

	var payloadToRevealText: String {
		var text = ""
		if let dataToReveal = collectPayload.map({$0.value}) as? [String], dataToReveal.count > 0 {
			text = Array(dataToReveal).joined(separator: "\n\n")
		}
		return text
	}

	/// Shared instance
	static let shared = DemoAppConfig()

	/// MARK: - Initializer

	private init() {}
}
