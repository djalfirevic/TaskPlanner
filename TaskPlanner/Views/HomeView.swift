//
//  HomeView.swift
//  TaskPlanner
//
//  Created by Djuro on 1/7/23.
//

import SwiftUI

struct HomeView: View {
	
	// MARK: - Properties
	
	@State private var currentDay = Date()
	@State private var tasks = sampleTasks
	@State private var addNewTask = false
	
	// MARK: - View
	
    var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			timeline
				.padding(15)
		}
		.safeAreaInset(edge: .top, spacing: 0) {
			header
		}
		.fullScreenCover(isPresented: $addNewTask) {
			AddTaskView(onAdd: { task in
				tasks.append(task)
			})
		}
    }
	
	// MARK: - Private API
	
	/// Header View
	@ViewBuilder
	private var header: some View {
		VStack {
			HStack {
				VStack(alignment: .leading, spacing: 6) {
					Text("Today")
						.ubuntu(30, .light)
					
					Text("Welcome Djuro")
						.ubuntu(14, .light)
				}
				.horizontalAlign(.leading)
				
				Button {
					addNewTask.toggle()
				} label: {
					HStack(spacing: 10) {
						Image(systemName: "plus")
						Text("Add Task")
							.ubuntu(15, .regular)
					}
					.padding(.vertical, 10)
					.padding(.horizontal, 15)
					.background {
						Capsule()
							.fill(Color.blue.gradient)
					}
					.foregroundColor(.white)
				}

			}
			
			/// Today's date.
			Text(Date().toString("MMM YYYY"))
				.ubuntu(16, .medium)
				.horizontalAlign(.leading)
				.padding(.top, 15)
			
			/// Current week row.
			weekRow
		}
		.padding(15)
		.background {
			VStack(spacing: 0) {
				Color.white
				
				Rectangle()
					.fill(.linearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom))
					.frame(height: 20)
			}
			.ignoresSafeArea()
		}
	}
	
	/// Week Row
	@ViewBuilder
	private var weekRow: some View {
		HStack(spacing: 0) {
			ForEach(Calendar.current.currentWeek) { weekDay in
				let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
				
				VStack(spacing: 6) {
					Text(weekDay.string.prefix(3))
						.ubuntu(12, .medium)
					Text(weekDay.date.toString("dd"))
						.ubuntu(16, status ? .medium : .regular)
				}
				.foregroundColor(status ? Color.blue : Color.gray)
				.horizontalAlign(.center)
				.contentShape(Rectangle())
				.onTapGesture {
					withAnimation(.easeInOut(duration: 0.3)) {
						currentDay = weekDay.date
					}
				}
			}
		}
		.padding(.vertical, 10)
		.padding(.horizontal, -15)
	}
	
	/// Timeline
	@ViewBuilder
	private var timeline: some View {
		ScrollViewReader { proxy in
			let hours = Calendar.current.hours
			let midHour = hours[hours.count / 2]
			
			VStack {
				ForEach(hours, id: \.self) { hour in
					timelineRow(hour)
						.id(hour)
				}
			}
			.onAppear {
				proxy.scrollTo(midHour)
			}
		}
	}
	
	/// Timeline Row
	@ViewBuilder
	private func timelineRow(_ date: Date) -> some View {
		HStack(alignment: .top) {
			Text(date.toString("h a"))
				.ubuntu(14, .regular)
				.frame(width: 45, alignment: .leading)
			
			/// Filtering tasks.
			let calendar = Calendar.current
			let filteredTasks = tasks.filter {
				if let hour = calendar.dateComponents([.hour], from: date).hour, let taskHour = calendar.dateComponents([.hour], from: $0.dateAdded).hour, hour == taskHour && calendar.isDate($0.dateAdded, inSameDayAs: currentDay) {
					return true
				}
				
				return false
			}
			
			if filteredTasks.isEmpty {
				Rectangle()
					.stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
					.frame(height: 0.5)
					.offset(y: 10)
			} else {
				/// Task view.
				VStack(spacing: 10) {
					ForEach(filteredTasks) { task in
						taskRow(task)
					}
				}
			}
		}
		.horizontalAlign(.leading)
		.padding(.vertical, 15)
	}
	
	@ViewBuilder
	private func taskRow(_ task: Task) -> some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(task.taskName.uppercased())
				.ubuntu(16, .regular)
				.foregroundColor(task.taskCategory.color)
			
			if task.taskDescription != "" {
				Text(task.taskDescription)
					.ubuntu(14, .light)
					.foregroundColor(task.taskCategory.color.opacity(0.8))
			}
		}
		.horizontalAlign(.leading)
		.padding(12)
		.background {
			ZStack(alignment: .leading) {
				Rectangle()
					.fill(task.taskCategory.color)
					.frame(width: 4)
				
				Rectangle()
					.fill(task.taskCategory.color.opacity(0.25))
			}
		}
	}
	
}

// MARK: - Previews

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
