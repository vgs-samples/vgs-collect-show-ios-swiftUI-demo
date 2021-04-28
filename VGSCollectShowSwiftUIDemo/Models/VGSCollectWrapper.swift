//
//  VGSCollectWrapper.swift
//  VGSCollectShowSwiftUIDemo
//
//  Created by Eugene on 22.03.2021.
//

import Foundation
import VGSCollectSDK

final class VGSCollectWrapper {

	// MARK: - Vars

	static let shared = VGSCollectWrapper()

	let vgsCollect = VGSCollect(id: DemoAppConfig.shared.vaultId, environment: .sandbox)

	// MARK: - Initialization

	private init() {}

	// MARK: - Interface

	func redactCard(completion: @escaping (String) -> ()) {
		vgsCollect.sendData(path: "/post") { response in

			switch response {
			case .success(_, let data, _):
				if let data = data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {

					print("SUCCESS: \(jsonData)")
					if let aliases = jsonData["json"] as? [String: Any],
						 let cardNumber = aliases["cardNumber"],
						 let expDate = aliases["expDate"] {

						let payload = [ "payment_card_number": cardNumber,
													 "payment_card_expiration_date": expDate]

						let statusText = self.textFromSuccessResponseData(data)
						completion(statusText)

						DemoAppConfig.shared.collectPayload = payload
						print(payload)
					}
				}
				return
			case .failure(let code, _, _, let error):
				//				self?.resultLabel.text = "Error \(code)"
				switch code {
				case 400..<499:
					// Wrong request. This also can happend when your Routs not setup yet or your <vaultId> is wrong
					print("Error: Wrong Request, code: \(code)")
				case VGSErrorType.inputDataIsNotValid.rawValue:
					if let error = error as? VGSError {
						print("Error: Input data is not valid. Details:\n \(error)")
					}
				default:
					print("Error: Something went wrong. Code: \(code)")
				}
				print("Submit request error: \(code), \(String(describing: error))")
				return
			}
		}
	}

	// MARK: - Private

	fileprivate func textFromSuccessResponseData(_ data: Data?) -> String {
		var text = ""
		if let data = data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
			// swiftlint:disable force_try
			let response = (String(data: try! JSONSerialization.data(withJSONObject: jsonData["json"]!, options: .prettyPrinted), encoding: .utf8)!)
			text = "Success: \n\(response)"
			print(response)
			// swiftlint:enable force_try
		}
		return text
	}
}
