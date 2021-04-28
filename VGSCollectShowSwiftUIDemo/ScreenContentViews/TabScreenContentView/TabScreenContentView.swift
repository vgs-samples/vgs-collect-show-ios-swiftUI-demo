//
//  TabScreenContentView.swift
//  VGSCollectShowSwiftUIDemo

import Foundation
import SwiftUI

struct TabScreenContentView: View {
	var body: some View {
		TabView {
			ShowScreenContentView()
				.tabItem {
					Text("Show")
				}
		  CollectScreenContentView()
				.tabItem {
					Text("Collect")
				}
		}
	}
}
