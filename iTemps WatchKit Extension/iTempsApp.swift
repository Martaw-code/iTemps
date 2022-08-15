//
//  iTempsApp.swift
//  iTemps WatchKit Extension
//
//  Created by Marta on 15/8/22.
//

import SwiftUI

@main
struct iTempsApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                WatchWeatherView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
