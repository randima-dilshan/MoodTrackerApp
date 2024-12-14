//
//  GraphView.swift
//  MoodTrackerApp
//
//  Created by Randima Dilshan on 2024-11-29.
//

import SwiftUI
import Charts

struct GraphView: View {
    var moodEntries: [MoodEntry]

    // Group data by moodEmoji and count occurrences
    private var emojiFrequency: [String: Int] {
        Dictionary(grouping: moodEntries, by: { $0.moodEmoji })
            .mapValues { $0.count }
    }

    var body: some View {
        VStack {
            if moodEntries.isEmpty {
                Text("No data to display")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                Chart {
                    ForEach(emojiFrequency.sorted(by: { $0.key < $1.key }), id: \.key) { emoji, count in
                        BarMark(
                            x: .value("Mood", emoji),
                            y: .value("Count", count)
                        )
                        .foregroundStyle(by: .value("Mood", emoji))
                    }
                }
                .chartLegend(.visible)
                .frame(height: 300)
                .padding()
            }
        }
        .navigationTitle("Mood Graph")
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample data for preview
        GraphView(moodEntries: [
            MoodEntry(moodEmoji: "😊", environmentTags: [], note: "", timestamp: Date()),
            MoodEntry(moodEmoji: "🥰", environmentTags: [], note: "", timestamp: Date()),
            MoodEntry(moodEmoji: "☹️", environmentTags: [], note: "", timestamp: Date()),
            MoodEntry(moodEmoji: "😡", environmentTags: [], note: "", timestamp: Date())
        ])
    }
}
