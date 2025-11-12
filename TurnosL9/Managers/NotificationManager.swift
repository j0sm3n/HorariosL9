//
//  NotificationManager.swift
//  Horarios L9
//
//  Created by Jose Antonio Mendoza on 31/10/25.
//

import NotificationCenter

@Observable
final class NotificationManager: NSObject {
    private let center = UNUserNotificationCenter.current()
    var isGranted: Bool = false
    var pendingRequests: [UNNotificationRequest] = []
    
    override init() {
        super.init()
        center.delegate = self
    }
    
    func requestAuthorization() async throws {
        try await center.requestAuthorization(options: [.sound, .badge, .alert])
        await getCurrentSettings()
    }
    
    func getCurrentSettings() async {
        let currentSettings = await center.notificationSettings()
        isGranted = (currentSettings.authorizationStatus == .authorized)
        print("isGranted: \(isGranted)")
    }
    
    func schedule(notification: LocalNotification) async {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.body

        if let subtitle = notification.subtitle {
            content.subtitle = subtitle
        }
        
        content.sound = UNNotificationSound.default
        
        let components = notification.dateComponents
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: notification.identifier, content: content, trigger: trigger)
        try? await center.add(request)

        await getPendingRequests()
    }
    
    func getPendingRequests() async {
        pendingRequests = await center.pendingNotificationRequests()
        print("Pending requests: \(pendingRequests.count)")
    }
    
    func removeRequest(withIdentifier identifier: String) {
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        if let index = pendingRequests.firstIndex(where: { $0.identifier == identifier }) {
            pendingRequests.remove(at: index)
            print("Pending requests: \(pendingRequests.count)")
        }
    }
    
    func clearRequests() {
        center.removeAllPendingNotificationRequests()
        pendingRequests.removeAll()
        print("Pending requests: \(pendingRequests.count)")
    }
    
    func scheduleNotification(for dates: [DateComponents]) {
        for date in dates {
            Task {
                let notification = LocalNotification(
                    identifier: UUID().uuidString,
                    title: "Horarios L9",
                    body: "Se acabó el descanso",
                    subtitle: "El tren sale en 5 minutos",
                    dateComponents: date.minus(5, component: .minute)
                )
                await schedule(notification: notification)
            }
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
}
