//
//  VGSCardIOSwiftUIScanner.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import SwiftUI

/// SwiftUI Wrapper for CardIO Scan View Controller.
struct VGSCardIOSwiftUIScanner: UIViewControllerRepresentable {

	// MARK: - UIViewControllerRepresentable

	typealias UIViewControllerType = VGSWrappedCardIOViewController

	let wrappedCardIOViewController: VGSWrappedCardIOViewController

	func makeUIViewController(context: UIViewControllerRepresentableContext<VGSCardIOSwiftUIScanner>) -> VGSWrappedCardIOViewController {
		return wrappedCardIOViewController
	}

	func updateUIViewController(_ uiViewController: VGSWrappedCardIOViewController, context: UIViewControllerRepresentableContext<VGSCardIOSwiftUIScanner>) {
	}
}
