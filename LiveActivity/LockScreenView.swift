//
//  LockScreenView.swift
//  Horarios L9
//
//  Created by Jose Antonio Mendoza on 1/4/25.
//

import SwiftUI
import WidgetKit

struct LockScreenView: View {
    let context: ActivityViewContext<ShiftAttributes>
    //    var remainingMinutes: String {
    //        context.attributes.endTime.timeIntervalSinceNow.positionalTimeString
    //    }
    // for testing
    var remainingMinutes: String {
        let now = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31, hour: 11, minute: 13))!
        return context.attributes.endTime.timeIntervalSince(now).minutesString
    }
    
    var finishDate: Date = Date().addingTimeInterval(300)
    
    var body: some View {
        switch context.state.shiftStatus {
        case .waiting:
            waitingView
        case .working:
            workingView
        case .finished:
            finishedView
        }
    }
    
    var waitingView: some View {
        HStack {
            VStack {
                Text("Próximo tren")
                    .foregroundStyle(.secondary)
                Label(context.state.trainNumber?.formatted() ?? "", systemImage: "tram.fill")
                    .font(.title3)
                    .bold()
            }
            Spacer()
            Text("13 min")
                .font(.largeTitle)
            Spacer()
            VStack(alignment: .trailing) {
                HStack {
                    Image(systemName: "arrow.up.right.circle")
                        .foregroundStyle(.secondary)
                    Text(context.state.origin ?? "")
                        .bold()
                    Text(context.state.departureTime?.formatted(date: .omitted, time: .shortened) ?? "")
                        .fontDesign(.monospaced)
                }
                HStack {
                    Image(systemName: "arrow.down.right.circle")
                        .foregroundStyle(.secondary)
                    Text(context.state.destination ?? "")
                        .bold()
                    Text(context.state.arrivalTime?.formatted(date: .omitted, time: .shortened) ?? "")
                        .fontDesign(.monospaced)
                }
            }
            .font(.callout)
        }
        .padding()
    }
    
    var workingView: some View {
        HStack {
            VStack {
                Text("Circulando")
                    .foregroundStyle(.secondary)
                Label(context.state.trainNumber?.formatted() ?? "", systemImage: "tram.fill")
                    .font(.title3)
                    .bold()
            }
            Spacer()
            HStack(spacing: 24){
                VStack {
                    Text(context.state.origin ?? "")
                        .bold()
                    Text(context.state.departureTime?.formatted(date: .omitted, time: .shortened) ?? "")
                        .fontDesign(.monospaced)
                }
                Image(systemName: "arrow.right")
                VStack {
                    Text(context.state.destination ?? "")
                        .bold()
                    Text(context.state.arrivalTime?.formatted(date: .omitted, time: .shortened) ?? "")
                        .fontDesign(.monospaced)
                }
            }
        }
        .padding()
    }
    
    var finishedView: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("Turno")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text(context.attributes.shiftName)
                .font(.largeTitle)
                .fontWeight(.black)
                .fontDesign(.rounded)
            Text("termina en")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text(context.attributes.endTime, style: .relative)
                .font(.largeTitle)
                .fontWeight(.black)
                .fontDesign(.rounded)
        }
        .padding()
    }
}
