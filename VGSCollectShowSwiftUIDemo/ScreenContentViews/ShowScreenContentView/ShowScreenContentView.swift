//
//  ShowScreenContentView.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import SwiftUI

struct ShowScreenContentView: View {

	/// App congig.
	@ObservedObject var appConfig = DemoAppConfig.shared

	// MARK: - View

	var body: some View {
		ScrollView(content: {
			Spacer(minLength: 30)
			VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
				VGSShowDemoSwiftUIView(vgsShow: VGSShowWrapper.shared.vgsShow).frame( height: 136, alignment: .center)
				Button(action: {
					VGSShowWrapper.shared.revealCard { (isSuccessfull) in
					}
				}, label: {
						Text("Show")
								.font(.title)
								.frame(width: 200)
								.foregroundColor(.white)
								.padding(.vertical, 10)
				})
				.background(
						Capsule()
							.fill(Color.blue)
				)
				VStack(spacing: 8, content: {
					Text("No data to reveal..").font(.subheadline)
					Text(appConfig.payloadToRevealText).font(.body).multilineTextAlignment(.leading)
				}).padding().frame(maxWidth: .infinity).background(Color(UIColor.secondarySystemBackground)).cornerRadius(6)
			}).padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
		})
	}
}
