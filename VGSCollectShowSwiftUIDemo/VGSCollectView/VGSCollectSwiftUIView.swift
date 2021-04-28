//
//  VGSCollectSwiftUIView.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import SwiftUI
import VGSCollectSDK

//// 
struct VGSCollectSwiftUIView: UIViewRepresentable {

	let vgsCollect: VGSCollect

	let collectView: VGSCollectView = VGSCollectView(frame: .zero)

	func makeUIView(context: UIViewRepresentableContext<VGSCollectSwiftUIView>) -> VGSCollectView {
		collectView.bindToVGSCollect(vgsCollect)
		return collectView
	}

	func updateUIView(_ uiView: VGSCollectView, context: Context) {}
}
