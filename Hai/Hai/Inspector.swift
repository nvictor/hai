//
//  Inspector.swift
//  Hai
//
//  Created by Victor Noagbodji on 11/1/25.
//

import SwiftUI

struct Inspector: View {
    @EnvironmentObject private var manager: AttendeeManager
    @State private var editingAttendee: Attendee?
    @State private var showingIconPicker = false
    @State private var showingAddAttendee = false
    @State private var newName = ""
    @State private var newAvatar = "👤"
    
    var body: some View {
        Form {
            Section("Attendees") {
                List {
                    ForEach($manager.attendees) { $attendee in
                        HStack {
                            Text(attendee.avatar)
                                .font(.system(size: 24))
                            TextField("Name", text: $attendee.name)
                                .textFieldStyle(.roundedBorder)
                            
                            Button {
                                editingAttendee = attendee
                                showingIconPicker = true
                            } label: {
                                Image(systemName: "face.smiling")
                            }
                            
                            Button(role: .destructive) {
                                if let index = manager.attendees.firstIndex(where: { $0.id == attendee.id }) {
                                    manager.attendees.remove(at: index)
                                }
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
        .sheet(isPresented: $showingIconPicker) {
            if let attendee = editingAttendee,
               let index = manager.attendees.firstIndex(where: { $0.id == attendee.id }) {
                IconPicker(avatar: $manager.attendees[index].avatar)
            }
        }
        .sheet(isPresented: $showingAddAttendee) {
            VStack(spacing: 20) {
                Text("Add Attendee")
                    .font(.headline)
                
                Text(newAvatar)
                    .font(.system(size: 60))
                
                Button("Choose Avatar") {
                    showingIconPicker = true
                }
                
                TextField("Name", text: $newName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                HStack {
                    Button("Cancel") {
                        showingAddAttendee = false
                        newName = ""
                        newAvatar = "👤"
                    }
                    .keyboardShortcut(.cancelAction)
                    
                    Button("Add") {
                        manager.attendees.append(
                            Attendee(name: newName, avatar: newAvatar)
                        )
                        showingAddAttendee = false
                        newName = ""
                        newAvatar = "👤"
                    }
                    .keyboardShortcut(.defaultAction)
                    .disabled(newName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .padding()
            .frame(width: 300, height: 300)
            .sheet(isPresented: $showingIconPicker) {
                IconPicker(avatar: $newAvatar)
            }
        }
    }
}
