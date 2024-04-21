//
//  File.swift
//  Pomodoro-Clone
//
//  Created by 江承恩 on 2024/4/6.
//


import SwiftUI

class PomodoroModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    // Timer Properties
    @Published var progress: CGFloat = 1
    @Published var timeStringValue: String = "00:00"
    @Published var isStarted: Bool = false
    @Published var addNewTimer: Bool = false
    
    @Published var hour: Int = 0
    @Published var minute: Int = 0
    @Published var seconds: Int = 0
    
    // Total seconds
    @Published var totalSeconds: Int = 0
    @Published var staticTotalSeconds: Int = 0
    
    @Published var isFinished: Bool = false
    
    override init(){
        super.init()
        self.authorizeNotification()
    }
    
    // Requset for notification access
    func authorizeNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]){_, _ in}
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        completionHandler([.sound, .banner])
    }
    
    // Starting Timer
    func startTimer(){
        withAnimation(.easeInOut(duration: 0.25)){isStarted = true}
        // Setting starting time value
        timeStringValue = "\(hour == 0 ? "" : "\(hour):")\(minute >= 10 ? "\(minute)" : "0\(minute)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        // Calculating total seconds for timer animation
        totalSeconds = (hour * 3600) + (minute * 60) + seconds
        staticTotalSeconds = totalSeconds
        addNewTimer = false
        addNotification()
    }
    // Stopping Timer
    func stopTimer(){
        withAnimation{
            isStarted = false
            hour = 0
            minute = 0
            seconds = 0
            progress = 1
        }
        totalSeconds = 0
        staticTotalSeconds = 0
        timeStringValue = "00:00"
    }
    // Updating Timer
    func updateTimer(){
        totalSeconds -= 1
        progress = CGFloat(totalSeconds)/CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress)
        hour = totalSeconds/3600
        minute = (totalSeconds/60) % 60
        seconds = totalSeconds % 60
        timeStringValue = "\(hour == 0 ? "" : "\(hour):")\(minute >= 10 ? "\(minute)" : "0\(minute)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        if hour == 0 && seconds == 0 && minute == 0{
            isStarted = false
            isFinished = true
        }
    }
    func addNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Timer"
        content.subtitle = "Congratulations!👏"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticTotalSeconds), repeats: false))
        
        UNUserNotificationCenter.current().add(request)
    }
}
