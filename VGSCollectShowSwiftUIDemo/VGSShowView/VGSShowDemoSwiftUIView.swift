//
//  VGSShowDemoSwiftUIView.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import SwiftUI
import VGSShowSDK

/// Wrapper for UIKit view with VGSShow views.
struct VGSShowDemoSwiftUIView: UIViewRepresentable {

	let vgsShow: VGSShow

	private let showDemoView: VGSShowDemoView = VGSShowDemoView(frame: .zero)

	// MARK: - UIViewRepresentable

	func makeUIView(context: UIViewRepresentableContext<VGSShowDemoSwiftUIView>) -> VGSShowDemoView {
		showDemoView.bindToShow(vgsShow)
		return showDemoView
	}

	func updateUIView(_ uiView: VGSShowDemoView, context: Context) {}
}
