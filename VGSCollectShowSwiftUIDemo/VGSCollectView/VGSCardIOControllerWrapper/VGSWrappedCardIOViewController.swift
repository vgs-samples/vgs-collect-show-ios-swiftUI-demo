//
//  VGSWrappedCardIOViewController.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import UIKit
import VGSCollectSDK

/// Intermmediate view controller to present from CardIO Scanner. We need some UIKit screen to present CardIO Scanner.
final class VGSWrappedCardIOViewController: UIViewController {

	// MARK: - Vars

	fileprivate let nc = NotificationCenter.default

	fileprivate let cardIOScanner = VGSCardIOScanController()

	fileprivate (set) internal var cardNumber: VGSTextField
	fileprivate (set) internal var expCardDate: VGSTextField

	fileprivate let activityIndicator = UIActivityIndicatorView()

	// MARK: - Initialization

	init(cardNumber: VGSTextField, expCardDate: VGSTextField) {
		self.cardNumber = cardNumber
		self.expCardDate = expCardDate
		super.init(nibName: nil, bundle: nil)
		self.cardIOScanner.delegate = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		addActivityIndicator()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		cardIOScanner.presentCardScanner(on: self, animated: false, completion: {[weak self] in
			self?.activityIndicator.stopAnimating()
		})
	}

	func addActivityIndicator() {
		view.addSubview(activityIndicator)
		activityIndicator.centerXToSuperview()
		activityIndicator.centerYToSuperview()

		activityIndicator.style = .medium
		activityIndicator.startAnimating()
	}
}

// MARK: - VGSCardIOScanControllerDelegate

extension VGSWrappedCardIOViewController: VGSCardIOScanControllerDelegate {

	//When user press Done button on CardIO screen
	func userDidFinishScan() {
		cardIOScanner.dismissCardScanner(animated: false, completion: {
			self.nc.post(Notification(name: Notification.Name(rawValue: "VGSCardScreenShouldDismiss.Notification")))
		})
	}

	//When user press Cancel button on CardIO screen
	func userDidCancelScan() {
		cardIOScanner.dismissCardScanner(animated: false, completion: {
			self.nc.post(Notification(name: Notification.Name(rawValue: "VGSCardScreenShouldDismiss.Notification")))
		})
	}

	//Asks VGSTextField where scanned data with type need to be set.
	func textFieldForScannedData(type: CradIODataType) -> VGSTextField? {
		switch type {
		case .expirationDateLong:
			return expCardDate
		case .cardNumber:
			return cardNumber
		default:
			return nil
		}
	}
}
