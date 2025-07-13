//
//  TurnosL9App.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 23/10/24.
//

import SwiftUI

@main
struct TurnosL9App: App {
    @State private var activityManager = LiveActivityManager()
    @State private var locationManger = LocationManager()
    @State private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            if locationManger.isAuthorized {
                ContentView()
                    .environment(activityManager)
                    .environment(viewModel)
                    .environment(locationManger)
            } else {
                UnauthorizedView()
            }
        }
    }
}
