//
//  View+Extensions.swift
//  TaskPlanner
//
//  Created by Djuro on 1/7/23.
//

import SwiftUI

enum Ubuntu {
	case light
	case bold
	case regular
	case medium
	
	var weight: Font.Weight {
		switch self {
		case .light:
			return .light
		case .bold:
			return .bold
		case .regular:
			return .regular
		case .medium:
			return .medium
		}
	}
}

extension View {
	
	func ubuntu(_ size: CGFloat, _ weight: Ubuntu) -> some View {
		self
			.font(.custom("Ubuntu", size: size))
			.fontWeight(weight.weight)
	}
	
	/// Helper to avoid using `Spacer` in order to move views.
	func horizontalAlign(_ alignment: Alignment) -> some View {
		self
			.frame(maxWidth: .infinity, alignment: alignment)
	}
	
	/// Helper to avoid using `Spacer` in order to move views.
	func verticalAlign(_ alignment: Alignment) -> some View {
		self
			.frame(maxHeight: .infinity, alignment: alignment)
	}
	
}
