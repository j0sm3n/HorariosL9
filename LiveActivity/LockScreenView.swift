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
        switch activityFamily {
        case .small:
            smallFamilyLockScreenView
        case .medium:
            mediumFamilyLockScreenView
        @unknown default:
            mediumFamilyLockScreenView
        }
    }
}

extension LockScreenView {
    var smallFamilyLockScreenView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(context.state.shiftStatus.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    if context.state.trainNumber > 0 {
                        HStack(spacing: 2) {
                            Image(systemName: context.state.shiftStatus.systemImageName)
                            Text(context.state.trainNumber, format: .number)
                                .contentTransition(.numericText())
                        }
                    } else {
                        HStack(spacing: 8) {
                            Image(systemName: context.state.shiftStatus.systemImageName)
                        }
                    }
                }
                Spacer()
                VStack(alignment: .trailing) {
                    if !context.state.nextStop.isEmpty {
                        Text("Próxima")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        HStack {
                            Text(context.state.nextStop)
                            Text(context.state.timeString)
                                .contentTransition(.numericText())
                        }
                    } else {
                        Text("Salida")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(context.state.timeString)
                            .font(.headline)
                    }
                }
            }
        }
        .padding(.horizontal, 6)
    }
    
    var mediumFamilyLockScreenView: some View {
        VStack {
            HStack {
                if context.state.trainNumber > 0 {
                    VStack(alignment: .leading) {
                        Text(context.state.shiftStatus.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        HStack {
                            Image(systemName: context.state.shiftStatus.systemImageName)
                            Text(context.state.trainNumber, format: .number)
                                .lockScreenStyle()
                                .contentTransition(.numericText())
                        }
                    }
                } else {
                    HStack(spacing: 8) {
                        Image(systemName: context.state.shiftStatus.systemImageName)
                        Text(context.state.shiftStatus.description)
                            .lockScreenStyle()
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
                                .fontDesign(.monospaced)
                                .contentTransition(.numericText())
                        }
                        .lockScreenStyle()
                    } else {
                        Text("Hora de salida")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(context.state.timeString)
                            .lockScreenStyle()
                    }
                }
            }
        }
        .padding()
    }
}
