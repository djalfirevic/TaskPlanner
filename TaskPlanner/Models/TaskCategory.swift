//
//  TaskCategory.swift
//  TaskPlanner
//
//  Created by Djuro on 1/7/23.
//

import SwiftUI

enum TaskCategory: String, CaseIterable {
	case general = "General"
	case bug = "Bug"
	case idea = "Idea"
	case modifiers = "Modifiers"
	case challenge = "Challenge"
	case coding = "Coding"
	
	var color: Color {
		switch self {
		case .general:
			return Color.gray
		case .bug:
			return Color.green
		case .idea:
			return Color.pink
		case .modifiers:
			return Color.blue
		case .challenge:
			return Color.purple
		case .coding:
			return Color.brown
		}
	}
}
