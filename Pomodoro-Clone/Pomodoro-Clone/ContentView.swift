//
//  ContentView.swift
//  Pomodoro-Clone
//
//  Created by 江承恩 on 2024/4/6.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pomodoroModel: PomodoroModel
    var body: some View {
        Home()
            .environmentObject(pomodoroModel)
    }
}
    
#Preview {
    ContentView()
}
