//
//  MoodTrackerAppApp.swift
//  MoodTrackerApp
//
//  Created by Randima Dilshan on 2024-11-29.
//

import SwiftUI

@main
struct MoodTrackerAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
