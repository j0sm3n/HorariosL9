//
//  LiveActivity.swift
//  LiveActivity
//
//  Created by Jose Antonio Mendoza on 31/3/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ShiftAttributes.self) { context in
            // Lock screen/banner UI goes here
            LockScreenView(context: context)
                .activityBackgroundTint(Color.cyan)
                .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("\(context.state.origin ?? "")")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("\(context.state.destination ?? "")")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("\(context.state.trainNumber ?? "")")
                    // more content
                }
            } compactLeading: {
                Text("\(context.state.origin ?? "")")
            } compactTrailing: {
                Text("\(context.state.destination ?? "")")
            } minimal: {
                Text("\(context.state.destination ?? "")")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ShiftAttributes {
    fileprivate static var preview: ShiftAttributes {
        let endTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 11, minute: 25))!
        return ShiftAttributes(shiftName: "1", endTime: endTime)
    }
}

extension ShiftAttributes.ContentState {
    fileprivate static var waiting9001: ShiftAttributes.ContentState {
        let departureTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 5, minute: 35))!
        let arrivalTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 6, minute: 56))!
        return ShiftAttributes.ContentState(shiftStatus: .waiting, trainNumber: "9001", origin: "B", destination: "D", departureTime: departureTime, arrivalTime: arrivalTime)
    }
    
    fileprivate static var working9001: ShiftAttributes.ContentState {
        let departureTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 5, minute: 50))!
        let arrivalTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 5, minute: 53))!
        return ShiftAttributes.ContentState(shiftStatus: .working, trainNumber: "9001", origin: "AT", destination: "GR", departureTime: departureTime, arrivalTime: arrivalTime)
    }
    
    fileprivate static var waiting9006: ShiftAttributes.ContentState {
        let departureTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 7, minute: 2))!
        let arrivalTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 8, minute: 24))!
        return ShiftAttributes.ContentState(shiftStatus: .waiting, trainNumber: "9006", origin: "D", destination: "B", departureTime: departureTime, arrivalTime: arrivalTime)
    }
    
    fileprivate static var working9006: ShiftAttributes.ContentState {
        let departureTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 7, minute: 17))!
        let arrivalTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 7, minute: 29))!
        return ShiftAttributes.ContentState(shiftStatus: .working, trainNumber: "9006", origin: "G", destination: "TE", departureTime: departureTime, arrivalTime: arrivalTime)
    }
    
    fileprivate static var finished: ShiftAttributes.ContentState {
        ShiftAttributes.ContentState(shiftStatus: .finished)
    }
}

#Preview("Notification", as: .content, using: ShiftAttributes.preview) {
    LiveActivity()
} contentStates: {
    ShiftAttributes.ContentState.waiting9001
    ShiftAttributes.ContentState.working9001
    ShiftAttributes.ContentState.waiting9006
    ShiftAttributes.ContentState.working9006
    ShiftAttributes.ContentState.finished
}
