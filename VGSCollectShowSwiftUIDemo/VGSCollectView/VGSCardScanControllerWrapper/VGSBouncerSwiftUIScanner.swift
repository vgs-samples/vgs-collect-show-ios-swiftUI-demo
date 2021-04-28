//
//  VGSBouncerSwiftUIScanner.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import SwiftUI

/// SwiftUI Wrapper for Bouncer View Controller.
struct VGSBouncerSwiftUIScanner: UIViewControllerRepresentable {

	// MARK: - UIViewControllerRepresentable

	typealias UIViewControllerType = VGSWrappedCardScannerViewController

	let wrappedBouncerViewController: VGSWrappedCardScannerViewController

	func makeUIViewController(context: UIViewControllerRepresentableContext<VGSBouncerSwiftUIScanner>) -> VGSWrappedCardScannerViewController {
		return wrappedBouncerViewController
	}

	func updateUIViewController(_ uiViewController: VGSWrappedCardScannerViewController, context: UIViewControllerRepresentableContext<VGSBouncerSwiftUIScanner>) {
	}
}
