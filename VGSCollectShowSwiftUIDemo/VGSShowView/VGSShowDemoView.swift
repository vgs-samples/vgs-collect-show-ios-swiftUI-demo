//
//  VGSShowDemoView.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import UIKit
import VGSShowSDK

class VGSShowDemoView: UIView {

	// MARK: - Vars

	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical

		stackView.distribution = .fill
		stackView.spacing = 16
		return stackView
	}()

	private lazy var cardNumberVGSLabel: VGSLabel = {
		let label = VGSLabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.placeholder = "Card number"
		label.font = UIFont.systemFont(ofSize: 14)
		label.placeholderStyle.color = UIColor.placeholderText
		label.placeholderStyle.textAlignment = .center
		label.textAlignment = .center

		label.contentPath = "json.payment_card_number"

		// Create regex object, split card number to XXXX XXXX XXXX XXXX format.
		do {
			let cardNumberPattern = "(\\d{4})(\\d{4})(\\d{4})(\\d{4})"
			let template = "$1 $2 $3 $4"
			let regex = try NSRegularExpression(pattern: cardNumberPattern, options: [])

			// Add transformation regex to your label.
			label.addTransformationRegex(regex, template: template)
		} catch {
			assertionFailure("invalid regex, error: \(error)")
		}

		return label
	}()

	private lazy var expirationDateLabel: VGSLabel = {
		let label = VGSLabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 14)
		label.placeholder = "Expiration date"
		label.placeholderStyle.color = UIColor.placeholderText
		label.placeholderStyle.textAlignment = .center
		label.textAlignment = .center

		label.contentPath = "json.payment_card_expiration_date"

		return label
	}()

	// MARK: - Initialization

	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(stackView)
		stackView.pinToSuperviewEdges()
		stackView.addArrangedSubview(cardNumberVGSLabel)
		stackView.addArrangedSubview(expirationDateLabel)

		cardNumberVGSLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
		expirationDateLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public

	func bindToShow(_ vgsShow: VGSShow) {
		vgsShow.subscribe(cardNumberVGSLabel)
		vgsShow.subscribe(expirationDateLabel)
	}
}
