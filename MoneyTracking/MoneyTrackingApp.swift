//
//  MoneyTrackingApp.swift
//  MoneyTracking
//
//  Created by Kai Nielsen on 2026/02/16.
//

import SwiftUI
import SwiftData

@main
struct MoneyTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}

