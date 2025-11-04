//
//  AttendeeManager.swift
//  Hai
//
//  Created by Victor Noagbodji on 11/1/25.
//

import Foundation
import SwiftUI
import Combine

class AttendeeManager: ObservableObject {
    private let saveKey = "attendees"
    
    @Published var attendees: [Attendee] = [] {
        didSet {
            saveAttendees()
        }
    }
    
    init() {
        loadAttendees()
        if attendees.isEmpty {
            attendees = [
                Attendee(name: "Victor", avatar: "\u{1F600}"),
                Attendee(name: "Aisha", avatar: "\u{1F601}"),
                Attendee(name: "Alex", avatar: "\u{1F602}"),
                Attendee(name: "Sam", avatar: "\u{1F603}"),
                Attendee(name: "Emily", avatar: "\u{1F604}"),
                Attendee(name: "Daniel", avatar: "\u{1F605}"),
                Attendee(name: "Sophia", avatar: "\u{1F606}"),
                Attendee(name: "Chris", avatar: "\u{1F607}"),
                Attendee(name: "Olivia", avatar: "\u{1F608}"),
                Attendee(name: "Ethan", avatar: "\u{1F609}")
            ]
        }
    }
    
    private func loadAttendees() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Attendee].self, from: data) {
            attendees = decoded
        }
    }
    
    private func saveAttendees() {
        if let encoded = try? JSONEncoder().encode(attendees) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func resetStates() {
        attendees = attendees.map { attendee in
            var updated = attendee
            updated.state = .notCalled
            return updated
        }
    }
}
