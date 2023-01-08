//
//  Calendar+Extensions.swift
//  TaskPlanner
//
//  Created by Djuro on 1/7/23.
//

import Foundation

extension Calendar {
	
	/// Returns 24 hours in a day.
	var hours: [Date] {
		let startOfDay = self.startOfDay(for: Date())
		
		var hours = [Date]()
		for index in 0..<24 {
			if let date = date(byAdding: .hour, value: index, to: startOfDay) {
				hours.append(date)
			}
		}
		
		return hours
	}
	
	/// Returns current week as an array.
	var currentWeek: [WeekDay] {
		guard let firstWeekDay = dateInterval(of: .weekOfMonth, for: Date())?.start else {
			return []
		}
		
		var weekDays = [WeekDay]()
		for index in 0..<7 {
			if let day = date(byAdding: .day, value: index, to: firstWeekDay) {
				let weekDaySymbol = day.toString("EEEE")
				let isToday = isDateInToday(day)
				weekDays.append(.init(string: weekDaySymbol, date: day, isToday: isToday))
			}
		}
		
		return weekDays
	}
	
	struct WeekDay: Identifiable {
		
		// MARK: - Properties
		let id = UUID()
		let string: String
		let date: Date
		let isToday: Bool
		
	}
	
}
