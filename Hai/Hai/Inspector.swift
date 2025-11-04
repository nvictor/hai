//
//  Inspector.swift
//  Hai
//
//  Created by Victor Noagbodji on 11/1/25.
//

import SwiftUI

struct Inspector: View {
    @EnvironmentObject private var manager: AttendeeManager
    @State private var editingAttendeeIndex: Int?
    @State private var showingAddAttendee = false
    @State private var newName = ""
    @State private var newAvatar = "\u{1F600}"
    @State private var showingNewAvatarPicker = false
    
    var body: some View {
        Form {
            Section("Attendees") {
                List {
                    ForEach(manager.attendees.indices, id: \.self) { index in
                        HStack {
                            Text(manager.attendees[index].avatar)
                                .font(.custom("Fontaku", size: 24))
                            TextField("Name", text: $manager.attendees[index].name)
                                .textFieldStyle(.roundedBorder)
                            
                            Button {
                                editingAttendeeIndex = index
                            } label: {
                                Image(systemName: "face.smiling")
                            }
                            
                            Button(role: .destructive) {
                                manager.attendees.remove(at: index)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                
                Button {
                    showingAddAttendee = true
                } label: {
                    Label("Add Attendee", systemImage: "plus")
                }
            }
            
            Section("Actions") {
                Button {
                    manager.resetStates()
                } label: {
                    Text("Reset All States")
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding()
        .frame(minWidth: 300)
        .sheet(item: Binding(
            get: { editingAttendeeIndex.map { IndexWrapper(index: $0) } },
            set: { editingAttendeeIndex = $0?.index }
        )) { wrapper in
            IconPicker(avatar: $manager.attendees[wrapper.index].avatar)
        }
        .sheet(isPresented: $showingAddAttendee) {
            VStack(spacing: 20) {
                Text("Add Attendee")
                    .font(.headline)
                
                Text(newAvatar)
                    .font(.custom("Fontaku", size: 60))
                
                Button("Choose Avatar") {
                    showingNewAvatarPicker = true
                }
                
                TextField("Name", text: $newName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                HStack {
                    Button("Cancel") {
                        showingAddAttendee = false
                        newName = ""
                        newAvatar = "\u{1F600}"
                    }
                    .keyboardShortcut(.cancelAction)
                    
                    Button("Add") {
                        manager.attendees.append(
                            Attendee(name: newName, avatar: newAvatar)
                        )
                        showingAddAttendee = false
                        newName = ""
                        newAvatar = "\u{1F600}"
                    }
                    .keyboardShortcut(.defaultAction)
                    .disabled(newName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .padding()
            .frame(width: 300, height: 300)
            .sheet(isPresented: $showingNewAvatarPicker) {
                IconPicker(avatar: $newAvatar)
            }
        }
    }
}

// Helper struct to make Int Identifiable for sheet(item:)
struct IndexWrapper: Identifiable {
    let id = UUID()
    let index: Int
}
