//
//  ContentView.swift
//  MoodTrackerApp
//
//  Created by Randima Dilshan on 2024-11-29.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @State private var moodEntries: [MoodEntry] = [] // State variable to hold data
    @State private var editingEntry: MoodEntry? = nil // Entry being edited

    var body: some View {
        NavigationView {
            List {
                ForEach(moodEntries) { entry in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(entry.moodEmoji)
                                .font(.largeTitle)
                            Spacer()
                            Text(formatDate(entry.timestamp))
                                .foregroundColor(.gray)
                                .font(.caption)
                        }

                        Text(entry.note)
                            .foregroundColor(.gray)
                            .lineLimit(1)

                        HStack {
                            ForEach(entry.environmentTags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .padding(4)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(5)
                            }
                        }
                    }
                    .contextMenu {
                        Button("Edit") {
                            editingEntry = entry // Set the entry to edit
                        }
                        Button("Delete", role: .destructive) {
                            deleteMood(entry: entry)
                        }
                    }
                }
                .onDelete(perform: deleteMood)
            }
            .navigationTitle("Mood Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: GraphView(moodEntries: moodEntries)) {
                        Image(systemName: "chart.bar.xaxis")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddMoodView { newEntry in
                        moodEntries.append(newEntry)
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $editingEntry) { entry in
                AddMoodView(
                    moodEntry: entry,
                    onSave: { updatedEntry in
                        if let index = moodEntries.firstIndex(where: { $0.id == updatedEntry.id }) {
                            moodEntries[index] = updatedEntry
                        }
                        editingEntry = nil
                    }
                )
            }
        }
    }

    // Helper to format date
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    // Delete a mood entry
    private func deleteMood(at offsets: IndexSet) {
        moodEntries.remove(atOffsets: offsets)
    }

    private func deleteMood(entry: MoodEntry) {
        moodEntries.removeAll { $0.id == entry.id }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
