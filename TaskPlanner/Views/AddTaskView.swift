//
//  AddTaskView.swift
//  TaskPlanner
//
//  Created by Djuro on 1/8/23.
//

import SwiftUI

struct AddTaskView: View {
	
	// MARK: - Properties
	
	var onAdd: (Task) -> Void
	@Environment(\.dismiss) private var dismiss
	@State private var taskName = ""
	@State private var taskDescription = ""
	@State private var taskDate = Date()
	@State private var taskCategory: TaskCategory = .general
	@State private var animateColor: Color = TaskCategory.general.color
	@State private var animate = false
	
	// MARK: - View
	
    var body: some View {
		VStack(alignment: .leading) {
			VStack(alignment: .leading, spacing: 10) {
				Button {
					dismiss()
				} label: {
					Image(systemName: "chevron.left")
						.foregroundColor(.white)
						.contentShape(Rectangle())
				}
				
				Text("Create New Task")
					.ubuntu(28, .light)
					.foregroundColor(.white)
					.padding(.vertical, 15)
				
				/// Title.
				TitleView("NAME")
				
				TextField("Make New Video", text: $taskName)
					.ubuntu(16, .regular)
					.tint(.white)
					.padding(.top, 2)
				
				Rectangle()
					.fill(.white.opacity(0.7))
					.frame(height: 1)
				
				/// Date.
				TitleView("DATE")
					.padding(.top, 15)
				
				HStack(alignment: .bottom, spacing: 12) {
					HStack(spacing: 12) {
						Text(taskDate.toString("EEEE dd, MMMM"))
							.ubuntu(16, .regular)
						
						/// Custom Date Picker.
						Image(systemName: "calendar")
							.font(.title3)
							.foregroundColor(.white)
							.overlay {
								DatePicker("", selection: $taskDate, displayedComponents: [.date])
									.blendMode(.destinationOver)
							}
						
						
					}
					.offset(y: -5)
					.overlay(alignment: .bottom) {
						Rectangle()
							.fill(.white.opacity(0.7))
							.frame(height: 1)
							.offset(y: 5)
					}
					
					HStack(spacing: 12) {
						Text(taskDate.toString("hh:mm a"))
							.ubuntu(16, .regular)
						
						/// Custom Date Picker.
						Image(systemName: "clock")
							.font(.title3)
							.foregroundColor(.white)
							.overlay {
								DatePicker("", selection: $taskDate, displayedComponents: [.hourAndMinute])
									.blendMode(.destinationOver)
							}
						
						
					}
					.offset(y: -5)
					.overlay(alignment: .bottom) {
						Rectangle()
							.fill(.white.opacity(0.7))
							.frame(height: 1)
							.offset(y: 5)
					}
				}
				.padding(.bottom, 15)
			}
			.environment(\.colorScheme, .dark)
			.horizontalAlign(.leading)
			.padding(15)
			.background {
				ZStack {
					taskCategory.color
					
					GeometryReader {
						let size = $0.size
						
						Rectangle()
							.fill(animateColor)
							.mask {
								Circle()
							}
							.frame(width: animate ? size.width * 2 : 0, height: animate ? size.height * 2 : 0)
							.offset(animate ? CGSize(width: -size.width / 2, height: -size.height / 2) : size)
					}
					.clipped()
				}
				.ignoresSafeArea()
			}
			
			VStack(alignment: .leading, spacing: 10) {
				TitleView("DESCRIPTION", color: .gray)
				
				TextField("About Your Task", text: $taskDescription)
					.ubuntu(16, .regular)
					.padding(.top, 2)
				
				Rectangle()
					.fill(.black.opacity(0.2))
					.frame(height: 1)
				
				/// Category.
				TitleView("CATEGORY", color: .gray)
					.padding(.top, 15)
				
				LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 3), spacing: 15) {
					ForEach(TaskCategory.allCases, id: \.rawValue) { category in
						Text(category.rawValue.uppercased())
							.ubuntu(12, .regular)
							.horizontalAlign(.center)
							.padding(.vertical, 5)
							.background {
								RoundedRectangle(cornerRadius: 5, style: .continuous)
									.fill(category.color.opacity(0.25))
							}
							.foregroundColor(category.color)
							.contentShape(Rectangle())
							.onTapGesture {
								guard !animate else { return }
								
								animateColor = category.color
								withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1, blendDuration: 1)) {
									animate = true
								}
								
								DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
									animate = false
									taskCategory = category
								}
							}
					}
				}
				.padding(.top, 5)
				
				Button {
					let task = Task(dateAdded: taskDate, taskName: taskName, taskDescription: taskDescription, taskCategory: taskCategory)
					onAdd(task)
					dismiss()
				} label: {
					Text("Create Task")
						.ubuntu(16, .regular)
						.foregroundColor(.white)
						.padding(.vertical, 15)
						.horizontalAlign(.center)
						.background {
							Capsule()
								.fill(animateColor.gradient)
						}
				}
				.verticalAlign(.bottom)
				.disabled(taskName == "" || animate)
				.opacity(taskName == "" ? 0.6 : 1)

			}
			.padding(15)
		}
		.verticalAlign(.top)
    }
	
	// MARK: - Private API
	
	/// Header View
	@ViewBuilder
	private func TitleView(_ value: String, color: Color = .white.opacity(0.7)) -> some View {
		Text(value)
			.ubuntu(12, .regular)
			.foregroundColor(color)
	}
	
}

// MARK: - Previews

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
		AddTaskView { _ in }
    }
}
