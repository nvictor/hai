//
//  Attendee.swift
//  Hai
//
//  Created by Victor Noagbodji on 11/1/25.
//

import Foundation

enum AttendeeState: Int, Codable {
    case notCalled = 0
    case present = 2
    case absent = 3
    case excused = 4
}

struct Attendee: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var avatar: String
    var state: AttendeeState = .notCalled
    
    init(id: UUID = UUID(), name: String, avatar: String, state: AttendeeState = .notCalled) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.state = state
    }
}
