//
//  CollectScreenContentView.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import SwiftUI

struct CollectScreenContentView: View {

	/// Defines active card scanner.
	enum ActiveScanner: Identifiable {

		/// CardIO scanner.
		case cardIO

		/// Bouncer card scanner.
		case bouncerCardScan

		var id: Int {
			hashValue
		}
	}

	// MARK: - Vars

	let vgsCollectWrapper = VGSCollectWrapper.shared

	/// Keep reference to `VGSCollectSwiftUIView` to bind card fields to scanner.
	var collectSwiftUIView: VGSCollectSwiftUIView = VGSCollectSwiftUIView(vgsCollect: VGSCollectWrapper.shared.vgsCollect)

	/// Listen to notification to dismiss active scanner.
	let pub = NotificationCenter.default
		.publisher(for: NSNotification.Name("VGSCardScreenShouldDismiss.Notification"))

	@State private var collectStateText: String = ""
	@State private var collectStatusText: String = "WAITING FOR INPUT:"

	@State private var activeScanner: ActiveScanner? = nil

	// MARK: - View

	var body: some View {
		ScrollView(content: {
			Spacer(minLength: 30)
			VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
				self.collectSwiftUIView.frame( height: 136, alignment: .center)
				HStack(content: {
					Button(action: {
						self.activeScanner = .cardIO
					}, label: {
						Text("CardIO")
							.font(.title)
							.frame(minWidth: 0, maxWidth: .infinity)
							.foregroundColor(.white)
							.padding(.vertical, 10)
					})
					.background(
						Capsule()
							.fill(Color.green)
					)
					Button(action: {
						self.activeScanner = .bouncerCardScan
					}, label: {
						Text("Bouncer")
							.font(.title)
							.frame(minWidth: 0, maxWidth: .infinity)
							.foregroundColor(.white)
							.padding(.vertical, 10)
					})
					.background(
						Capsule()
							.fill(Color.blue)
					)
				})
				Button(action: {
					vgsCollectWrapper.redactCard { (statusText) in
						self.collectStateText = statusText
					}
				}, label: {
					Text("Collect")
						.font(.title)
						.frame(minWidth: 0, maxWidth: .infinity)
						.foregroundColor(.white)
						.padding(.vertical, 10)
				})
				.background(
					Capsule().fill(Color.black)
				)
				VStack(spacing: 8, content: {
					Text(collectStatusText).font(.subheadline)
					if !collectStateText.isEmpty {
						Text(collectStateText).font(Font(UIFont.systemFont(ofSize: 14, weight: .light))).multilineTextAlignment(.leading)
					} else {
						EmptyView()
					}
				}).padding().frame(maxWidth: .infinity).background(Color(UIColor.secondarySystemBackground)).cornerRadius(6)
			}).padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
		}).onTapGesture {
			UIApplication.shared.endEditing()
		}.sheet(item: $activeScanner) { item in
			switch item {
			case .cardIO:
				VGSCardIOSwiftUIScanner(wrappedCardIOViewController: VGSWrappedCardIOViewController(cardNumber: collectSwiftUIView.collectView.cardNumberField, expCardDate: collectSwiftUIView.collectView.expDateField))
			case .bouncerCardScan:
				VGSBouncerSwiftUIScanner(wrappedBouncerViewController: VGSWrappedCardScannerViewController(cardNumber: collectSwiftUIView.collectView.cardNumberField, expCardDate: collectSwiftUIView.collectView.expDateField))
			}
		}.onReceive(pub) { _ in
			self.activeScanner = nil
		}.onAppear(perform: {
			self.vgsCollectWrapper.vgsCollect.observeStates = { form in

				self.collectStatusText = "STATE:\n"
				self.collectStateText = ""

				form.forEach({ textField in
					self.collectStateText.append(textField.state.description)
					self.collectStateText.append("\n")
				})
			}
		})
	}
}
