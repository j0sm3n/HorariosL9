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
            LockScreenView(context: context)
                .activityBackgroundTint(Color.cyan)
                .activitySystemActionForegroundColor(Color.black)
        } dynamicIsland: { context in
            createDynamicIsland(context: context)
        }
    }
}

extension LiveActivity {
    func createDynamicIsland(context: ActivityViewContext<ShiftAttributes>) -> DynamicIsland {
        switch context.state.shiftStatus {
            case .waiting:
                return waitingDynamicIsland(context: context)
            case .working:
                return workingDynamicIsland(context: context)
            case .finished:
                return finishedDynamicIsland(context: context)
        }
    }
    
    func waitingDynamicIsland(context: ActivityViewContext<ShiftAttributes>) -> DynamicIsland {
        DynamicIsland {
            DynamicIslandExpandedRegion(.leading) {
                VStack {
                    Text("\(context.state.origin!)")
                    Text("\(context.state.departureTime!.formatted(date: .omitted, time: .shortened))")
                }
                .padding(.top)
            }
            DynamicIslandExpandedRegion(.trailing) {
                VStack {
                    Text("\(context.state.destination!)")
                    Text("\(context.state.arrivalTime!.formatted(date: .omitted, time: .shortened))")
                }
                .padding(.top)
            }
            DynamicIslandExpandedRegion(.center) {
                VStack {
                    Text("Próximo tren")
                        .foregroundStyle(.secondary)
                    Label(context.state.trainNumber?.formatted() ?? "", systemImage: "tram.fill")
                        .font(.title3)
                        .bold()
                }
            }
            DynamicIslandExpandedRegion(.bottom) {
                Text("Sale en \(context.state.departureTime!, style: .offset)")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        } compactLeading: {
            Image(systemName: "tram.circle")
        } compactTrailing: {
            Text(context.state.departureTime!, style: .offset)
        } minimal: {
            Text(context.state.departureTime!, style: .offset)
        }
        .keylineTint(Color.red)
    }
    
    func workingDynamicIsland(context: ActivityViewContext<ShiftAttributes>) -> DynamicIsland {
        DynamicIsland {
            DynamicIslandExpandedRegion(.leading) {
                Text("\(context.state.origin ?? "")")
            }
            DynamicIslandExpandedRegion(.trailing) {
                Text("\(context.state.destination ?? "")")
            }
            DynamicIslandExpandedRegion(.bottom) {
                Text("\(context.state.trainNumber?.formatted() ?? "")")
                // more content
            }
        } compactLeading: {
            Text("\(context.state.origin ?? "")")
        } compactTrailing: {
            Text("\(context.state.destination ?? "")")
        } minimal: {
            Text("\(context.state.destination ?? "")")
        }
        .keylineTint(Color.red)
    }
    
    func finishedDynamicIsland(context: ActivityViewContext<ShiftAttributes>) -> DynamicIsland {
        DynamicIsland {
            DynamicIslandExpandedRegion(.leading) {
                Text("\(context.state.origin ?? "")")
            }
            DynamicIslandExpandedRegion(.trailing) {
                Text("\(context.state.destination ?? "")")
            }
            DynamicIslandExpandedRegion(.bottom) {
                Text("\(context.state.trainNumber?.formatted() ?? "")")
                // more content
            }
        } compactLeading: {
            Text("\(context.state.origin ?? "")")
        } compactTrailing: {
            Text("\(context.state.destination ?? "")")
        } minimal: {
            Text("\(context.state.destination ?? "")")
        }
        .keylineTint(Color.red)
    }
}

extension ShiftAttributes {
    fileprivate static var preview: ShiftAttributes {
        let endTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 11, minute: 25))!
        return ShiftAttributes(shiftName: "1", endTime: endTime)
    }
}

extension ShiftAttributes.ContentState {
//    fileprivate static var waiting9001: ShiftAttributes.ContentState {
//        let departureTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 5, minute: 35))!
//        let arrivalTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 6, minute: 56))!
//        return ShiftAttributes.ContentState(shiftStatus: .waiting, trainNumber: 9001, origin: "B", destination: "D", departureTime: departureTime, arrivalTime: arrivalTime)
//    }
//    
//    fileprivate static var working9001: ShiftAttributes.ContentState {
//        let departureTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 5, minute: 50))!
//        let arrivalTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 5, minute: 53))!
//        return ShiftAttributes.ContentState(shiftStatus: .working, trainNumber: 9001, origin: "AT", destination: "GR", departureTime: departureTime, arrivalTime: arrivalTime)
//    }
//    
//    fileprivate static var waiting9006: ShiftAttributes.ContentState {
//        let departureTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 7, minute: 2))!
//        let arrivalTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 8, minute: 24))!
//        return ShiftAttributes.ContentState(shiftStatus: .waiting, trainNumber: 9006, origin: "D", destination: "B", departureTime: departureTime, arrivalTime: arrivalTime)
//    }
//    
//    fileprivate static var working9006: ShiftAttributes.ContentState {
//        let departureTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 7, minute: 17))!
//        let arrivalTime = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 7, minute: 29))!
//        return ShiftAttributes.ContentState(shiftStatus: .working, trainNumber: 9006, origin: "G", destination: "TE", departureTime: departureTime, arrivalTime: arrivalTime)
//    }
//    
//    fileprivate static var finished: ShiftAttributes.ContentState {
//        ShiftAttributes.ContentState(shiftStatus: .finished)
//    }
}

//#Preview("Notification", as: .content, using: ShiftAttributes.preview) {
//    LiveActivity()
//} contentStates: {
//    ShiftAttributes.ContentState.waiting9001
//    ShiftAttributes.ContentState.working9001
//    ShiftAttributes.ContentState.waiting9006
//    ShiftAttributes.ContentState.working9006
//    ShiftAttributes.ContentState.finished
//}
