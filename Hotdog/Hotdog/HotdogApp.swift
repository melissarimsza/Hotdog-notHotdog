//
//  HotdogApp.swift
//  Hotdog
//
//  Created by Melissa Rimsza on 3/28/22.
//

import SwiftUI

@main
struct HotdogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(classifier: ImageClassifier())
        }
    }
}
