//
//  UIApplication+Extensions.swift
//  VGSCollectShowSwiftUIDemo
//

import Foundation
import UIKit

extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
