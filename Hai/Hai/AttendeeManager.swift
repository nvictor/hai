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
                Attendee(name: "Victor", avatar: "👨🏾‍💻"),
                Attendee(name: "Aisha", avatar: "👩🏾"),
                Attendee(name: "Alex", avatar: "🧑‍🚀"),
                Attendee(name: "Sam", avatar: "👨🏻"),
                Attendee(name: "Emily", avatar: "👩🏼"),
                Attendee(name: "Daniel", avatar: "👨🏽‍🎓"),
                Attendee(name: "Sophia", avatar: "👩‍⚕️"),
                Attendee(name: "Chris", avatar: "👨‍🔧"),
                Attendee(name: "Olivia", avatar: "👩‍🔬"),
                Attendee(name: "Ethan", avatar: "👨‍🏫")
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
        for i in attendees.indices {
            attendees[i].state = .notCalled
        }
    }
}
