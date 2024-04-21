//
//  SnakeApp.swift
//  Snake
//
//  Created by 江承恩 on 2024/2/25.
//

import SwiftUI

@main
struct SnakeApp: App {
    
    @StateObject var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().id(appState.gameID)
        }
    }
}

//Create a global app state
class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var gameID = UUID()
}
