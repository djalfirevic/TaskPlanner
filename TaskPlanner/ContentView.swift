//
//  ContentView.swift
//  TaskPlanner
//
//  Created by Djuro on 1/7/23.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - View
	
    var body: some View {
        HomeView()
			.preferredColorScheme(.light)
    }
	
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
