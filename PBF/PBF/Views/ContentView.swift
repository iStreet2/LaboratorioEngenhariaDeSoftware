//
//  ContentView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 13/09/23.
//

import SwiftUI

struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
