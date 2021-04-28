//
//  VGSShowWrapper.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import VGSShowSDK

final class VGSShowWrapper {

	// MARK: - Vars

	static let shared = VGSShowWrapper()

	let vgsShow = VGSShow(id: DemoAppConfig.shared.vaultId, environment: .sandbox)

	// MARK: - Initialization

	private init() {}

	// MARK: - Interface

	func revealCard(completion: @escaping (Bool) -> ()) {
		vgsShow.request(path: DemoAppConfig.shared.path,
										method: .post, payload: DemoAppConfig.shared.collectPayload) { (requestResult) in

			switch requestResult {
			case .success(let code):
				print("vgsshow success, code: \(code)")
				completion(true)
			case .failure(let code, let error):
				print("vgsshow failed, code: \(code), error: \(error)")
				completion(false)
			}
		}
	}
}
