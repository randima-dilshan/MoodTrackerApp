//
//  MoodEntry.swift
//  MoodTrackerApp
//
//  Created by Randima Dilshan on 2024-11-29.
//

import Foundation

struct MoodEntry: Identifiable {
    let id = UUID()
    var moodEmoji: String
    var environmentTags: [String]
    var note: String
    var timestamp: Date = Date() // Add timestamp property
}
