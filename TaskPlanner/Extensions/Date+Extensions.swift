//
//  Date+Extensions.swift
//  TaskPlanner
//
//  Created by Djuro on 1/7/23.
//

import Foundation

extension Date {
	
	func toString(_ format: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.string(from: self)
	}
	
}
