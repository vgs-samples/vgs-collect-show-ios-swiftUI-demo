//
//  VGSWrappedCardScannerViewController.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import VGSCollectSDK

/// Intermmediate view controller to present BouncerScanner.
final class VGSWrappedCardScannerViewController: UIViewController {

	// MARK: - Vars

	fileprivate let nc = NotificationCenter.default

	fileprivate var isBouncerPresented = false

	fileprivate let bouncerScanner = VGSCardScanController(apiKey: "")

	// Keep references for VGS fields in form.
	fileprivate (set) internal var cardNumber: VGSTextField
	fileprivate (set) internal var expCardDate: VGSTextField

	fileprivate let activityIndicator = UIActivityIndicatorView()

	// MARK: - Initialization

	init(cardNumber: VGSTextField, expCardDate: VGSTextField) {
		self.cardNumber = cardNumber
		self.expCardDate = expCardDate
		super.init(nibName: nil, bundle: nil)
		self.bouncerScanner.delegate = self
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

		// Prevent displaying bouncer multiple times.
		if isBouncerPresented {
			return
		}

		bouncerScanner.presentCardScanner(on: self, animated: true, completion: {[weak self] in
			self?.isBouncerPresented = true
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

// MARK: - VGSCardScanControllerDelegate

extension VGSWrappedCardScannerViewController: VGSCardScanControllerDelegate {

	func userDidFinishScan() {
		bouncerScanner.dismissCardScanner(animated: false, completion: {
			self.dismiss(animated: false, completion: {
				self.nc.post(Notification(name: Notification.Name(rawValue: "VGSCardScreenShouldDismiss.Notification")))
			})
		})
	}

	func userDidCancelScan() {
		bouncerScanner.dismissCardScanner(animated: false, completion: {
			self.nc.post(Notification(name: Notification.Name(rawValue: "VGSCardScreenShouldDismiss.Notification")))

		})
	}

	//Asks VGSTextField where scanned data with type need to be set.
	func textFieldForScannedData(type: CradScanDataType) -> VGSTextField? {
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
