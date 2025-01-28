//
//  UnauthorizedView.swift
//  Horarios L9
//
//  Created by Jose Antonio Mendoza on 18/1/25.
//

import SwiftUI

struct UnauthorizedView: View {
    var body: some View {
        ContentUnavailableView {
            Label("Localización no autorizada", systemImage: "location.slash")
        } description: {
            Text("""
                1. Pulsa el botón de abajo para ir a "Privacidad y seguridad"
                2. Pulsa en "Localización"
                3. Busca "Horarios L9" y pulsa en él
                4. Cambiar el ajuste a "Cuando se use la app"
            """)
            .multilineTextAlignment(.leading)
        } actions: {
            Button("Abrir Ajustes") {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    UnauthorizedView()
}
