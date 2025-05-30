//
//  LockScreenView.swift
//  Horarios L9
//
//  Created by Jose Antonio Mendoza on 1/4/25.
//

import SwiftUI
import WidgetKit

struct LockScreenView: View {
    @Environment(\.activityFamily) var activityFamily

    let context: ActivityViewContext<JourneyAttributes>
    
    var body: some View {
        VStack {
            HStack {
                if context.state.trainNumber > 0 {
                    VStack(alignment: .leading) {
                        if activityFamily == .medium {
                            Text(context.state.shiftStatus.description)
                                .font(.headline)
                        }
                        HStack {
                            Image(systemName: context.state.shiftStatus.systemImageName)
                            Text(context.state.trainNumber, format: .number)
                                .contentTransition(.numericText())
                        }
                    }
                } else {
                    HStack(spacing: 8) {
                        Text(context.state.shiftStatus.description)
                            .font(.headline)
                        Image(systemName: context.state.shiftStatus.systemImageName)
                    }
                }
                Spacer()
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
        }
        .padding()
    }
}
