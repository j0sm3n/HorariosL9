//
//  JourneyActivityWidget.swift
//  LiveActivityExtension
//
//  Created by Jose Antonio Mendoza on 14/5/25.
//

import SwiftUI
import WidgetKit

struct JourneyActivityWidget: Widget {
    @Environment(\.activityFamily) var activityFamily
    @Environment(\.colorScheme) var colorScheme

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: JourneyAttributes.self) { context in
            LockScreenView(context: context)
                .preferredColorScheme(activityFamily == .small ? .dark : colorScheme)
                .activityBackgroundTint(Color.row)
                .activitySystemActionForegroundColor(Color.black)
        } dynamicIsland: { context in
            createDynamicIsland(context: context)
        }
        .supplementalActivityFamilies([.medium, .small])
    }
}

extension JourneyActivityWidget {
    func createDynamicIsland(context: ActivityViewContext<JourneyAttributes>) -> DynamicIsland {
        DynamicIsland {
            DynamicIslandExpandedRegion(.leading) {
                VStack(alignment: .leading) {
                    Text(context.state.shiftStatus.description)
                        .font(.headline)
                    HStack {
                        Image(systemName: context.state.shiftStatus.systemImageName)
                        if context.state.trainNumber > 0 {
                            Text(context.state.trainNumber, format: .number)
                        }
                    }
                }
            }
            DynamicIslandExpandedRegion(.trailing) {
                VStack(alignment: .trailing) {
                    if !context.state.nextStop.isEmpty {
                        Text("Próxima parada")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        HStack {
                            Text(context.state.nextStop)
                            Text(context.state.timeString)
                                .contentTransition(.numericText())
                        }
                        .font(.headline)
                    } else {
                        Text("Hora de salida")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(context.state.timeString)
                            .font(.headline)
                    }
                }
            }
        } compactLeading: {
            Text(context.state.nextStop)
        } compactTrailing: {
            Text(context.state.timeString)
                .contentTransition(.numericText())
        } minimal: {
            Text(context.state.timeString)
        }
    }
}
