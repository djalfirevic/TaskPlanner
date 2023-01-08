//
//  Task.swift
//  TaskPlanner
//
//  Created by Djuro on 1/7/23.
//

import Foundation

struct Task: Identifiable {
	
	// MARK: - Properties
	let id = UUID()
	let dateAdded: Date
	let taskName: String
	let taskDescription: String
	let taskCategory: TaskCategory
	
}

var sampleTasks: [Task] = [
	.init(dateAdded: Date(timeIntervalSince1970: 1673164203), taskName: "Edit YT Video", taskDescription: "", taskCategory: .general),
	.init(dateAdded: Date(timeIntervalSince1970: 1673165203), taskName: "Matched Geometry Effect (Issue)", taskDescription: "", taskCategory: .bug),
	.init(dateAdded: Date(timeIntervalSince1970: 1673165203), taskName: "Multi-ScrollView", taskDescription: "", taskCategory: .challenge),
	.init(dateAdded: Date(timeIntervalSince1970: 1673195203), taskName: "Loreal Ipsum", taskDescription: "Lorem Ipsum is simply a dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1500s.", taskCategory: .idea),
	.init(dateAdded: Date(timeIntervalSince1970: 1673255203), taskName: "Complete UI Animation Challenge", taskDescription: "", taskCategory: .challenge),
	.init(dateAdded: Date(timeIntervalSince1970: 1673255203), taskName: "Fix Shadow issue on Mockup's", taskDescription: "", taskCategory: .bug),
	.init(dateAdded: Date(timeIntervalSince1970: 1673295203), taskName: "Add Shadow Effect in Mockview App", taskDescription: "", taskCategory: .idea),
	.init(dateAdded: Date(timeIntervalSince1970: 1676295203), taskName: "Twitter/Instagram Post", taskDescription: "", taskCategory: .general),
	.init(dateAdded: Date(timeIntervalSince1970: 1676295203), taskName: "Lorem Ipsum", taskDescription: "", taskCategory: .modifiers)
]
