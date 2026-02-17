//
//  ContentView.swift
//  MoneyTracking
//
//  Created by Kai Nielsen on 2026/02/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ThisMonthView()
                .tabItem {
                    Label("今月", systemImage: "calendar")
                }

            TotalView()
                .tabItem {
                    Label("合計", systemImage: "chart.bar")
                }
        }
    }
}
