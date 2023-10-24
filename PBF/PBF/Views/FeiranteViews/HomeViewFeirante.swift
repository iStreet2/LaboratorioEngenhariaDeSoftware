//
//  TabView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 23/10/23.
//

import SwiftUI

struct HomeViewFeirante: View {
    var body: some View {
        TabView {
            FeirasView()
                .tabItem {
                    Label("Feiras", systemImage: "storefront")
                }
            
            CartView()
                .tabItem {
                    Label("Carrinho", systemImage: "cart")
                }
            
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }
        }
    }
}

#Preview {
    HomeViewFeirante()
}
