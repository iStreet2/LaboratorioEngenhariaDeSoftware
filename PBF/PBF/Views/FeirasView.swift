//
//  BarracasView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI

struct FeirasView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    BarracaCard()
                }
                .padding()
            }
            .navigationTitle("Feira")
        }
        
    }
}

#Preview {
    FeirasView()
}
