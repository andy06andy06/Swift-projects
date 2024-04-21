//
//  Pomodoro_CloneApp.swift
//  Pomodoro-Clone
//
//  Created by 江承恩 on 2024/4/6.
//

import SwiftUI

@main
struct PomodoroTimerApp: App {
    @StateObject var pomodoroModel: PomodoroModel = .init()
    // Scene phase
    @Environment(\.scenePhase) var phase
    // Storing last time stamp
    @State var lastActiveTimeStamp: Date = Date()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pomodoroModel)
        }
        .onChange(of: phase){ newValue in
            if pomodoroModel.isStarted{
                if newValue == .background{
                    lastActiveTimeStamp = Date()
                }
                if newValue == .active{
                    // Finding the difference
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    if pomodoroModel.totalSeconds - Int(currentTimeStampDiff) <= 0 {
                        pomodoroModel.isStarted = false
                        pomodoroModel.totalSeconds = 0
                        pomodoroModel.isFinished = true
                    }else{
                        pomodoroModel.totalSeconds -= Int(currentTimeStampDiff)
                    }
                }
            }
        }
    }
}
