//
//  TrainListView.swift
//  Horarios L9
//
//  Created by Jose Antonio Mendoza on 13/7/25.
//

import SwiftUI

struct TrainListView: View {
    let trains: [Train]

    var body: some View {
        ScrollView {
            ForEach(trains) { train in
                NavigationLink(value: train) {
                    TrainRowView(train: train, color: train.color, showIndicator: true)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    TrainListView(trains: .preview)
}
