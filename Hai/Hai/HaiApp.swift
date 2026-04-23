//
//  HaiApp.swift
//  Hai
//
//  Created by Victor Noagbodji on 11/1/25.
//

import SwiftUI

@main
struct HaiApp: App {
    @StateObject private var attendeeManager = AttendeeManager()
    @StateObject private var updater = AppUpdater()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(attendeeManager)
        }
        .commands {
            CheckForUpdatesCommands(updater: updater)
        }
    }
}
