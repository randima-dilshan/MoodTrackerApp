//
//  AddMoodView.swift
//  MoodTrackerApp
//
//  Created by Randima Dilshan on 2024-11-29.
//

import SwiftUI

struct AddMoodView: View {
    var moodEntry: MoodEntry? = nil // Optional for editing
    var onSave: (MoodEntry) -> Void

    @State private var selectedMood: String = "😊"
    @State private var environmentTags: Set<String> = []
    @State private var note: String = ""

    @Environment(\.presentationMode) var presentationMode

    private let moods = ["😊", "🥰", "☹️",  "😡", "😭"]
    private let environments = ["Exercise", "Family", "School", "Work"]

    init(moodEntry: MoodEntry? = nil, onSave: @escaping (MoodEntry) -> Void) {
        self.moodEntry = moodEntry
        self.onSave = onSave
    }

    var body: some View {
        Form {
            // Mood Section
            Section(header: Text("Mood")) {
                HStack {
                    ForEach(moods, id: \.self) { mood in
                        Button(action: {
                            selectedMood = mood
                        }) {
                            Text(mood)
                                .font(.largeTitle)
                                .padding()
                                .background(selectedMood == mood ? Color.blue.opacity(0.2) : Color.clear)
                                .cornerRadius(10)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }

            // Environment Section
            Section(header: Text("Environment")) {
                ForEach(environments, id: \.self) { environment in
                    HStack {
                        Text(environment)
                        Spacer()
                        Button(action: {
                            toggleEnvironment(environment)
                        }) {
                            Image(systemName: environmentTags.contains(environment) ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(environmentTags.contains(environment) ? .blue : .gray)
                        }
                    }
                }
            }

            // Note Section
            Section(header: Text("Note")) {
                TextField("Write about your mood...", text: $note)
            }
        }
        .navigationTitle(moodEntry == nil ? "Add Mood" : "Edit Mood")
        .onAppear {
            // Populate fields if editing
            if let moodEntry = moodEntry {
                selectedMood = moodEntry.moodEmoji
                environmentTags = Set(moodEntry.environmentTags)
                note = moodEntry.note
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    let newEntry = MoodEntry(
                       
                        moodEmoji: selectedMood,
                        environmentTags: Array(environmentTags),
                        note: note,
                        timestamp: moodEntry?.timestamp ?? Date()
                    )
                    onSave(newEntry)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }

    private func toggleEnvironment(_ environment: String) {
        if environmentTags.contains(environment) {
            environmentTags.remove(environment)
        } else {
            environmentTags.insert(environment)
        }
    }
}

struct AddMoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddMoodView { _ in }
    }
}
