//
//  TurnosL9WatchOSApp.swift
//  TurnosL9WatchOS Watch App
//
//  Created by Jose Antonio Mendoza on 26/9/25.
//

import SwiftUI

@main
struct TurnosL9WatchOS_Watch_AppApp: App {
    @State private var store = ShiftStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}
