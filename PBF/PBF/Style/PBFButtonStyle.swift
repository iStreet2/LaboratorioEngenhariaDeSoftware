//
//  PBFButtonSyle.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI

struct PBFButtonSyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 15)
            .padding(.horizontal, 140)
            .foregroundStyle(.white)
            .background(.black, in: Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1)
            .multilineTextAlignment(.center)
        
    }
}

#Preview {
    Button("Começar Pedido!") {
    }
    .buttonStyle(PBFButtonSyle())
}
