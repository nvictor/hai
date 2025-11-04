//
//  ContentView.swift
//  Hai
//
//  Created by Victor Noagbodji on 11/1/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var manager: AttendeeManager
    @State private var showInspector = false
    
    let columns = [
        GridItem(.adaptive(minimum: 120, maximum: 140), spacing: 20)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(manager.attendees) { attendee in
                    AvatarCard(attendee: attendee) {
                        if let index = manager.attendees.firstIndex(where: { $0.id == attendee.id }) {
                            cycleState(at: index)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Hai!")
        .inspector(isPresented: $showInspector) {
            Inspector()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    manager.resetStates()
                } label: {
                    Label("Reset", systemImage: "arrow.counterclockwise")
                }
            }
            ToolbarItem {
                Button {
                    showInspector.toggle()
                } label: {
                    Label("Settings", systemImage: "sidebar.trailing")
                }
            }
        }
    }
    
    private func cycleState(at index: Int) {
        let currentState = manager.attendees[index].state
        switch currentState {
        case .notCalled:
            manager.attendees[index].state = .calledOrAbsent
        case .calledOrAbsent:
            manager.attendees[index].state = .notCalled
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AttendeeManager())
}
