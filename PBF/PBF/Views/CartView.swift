//
//  CartView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("CartView")
                }
            }
            .navigationTitle("Carrinho")
        }
    }
}

#Preview {
    CartView()
}
