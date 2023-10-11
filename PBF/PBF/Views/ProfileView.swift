//
//  ProfileView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("ProfileView")
                }
            }
            .navigationTitle("Perfil")
        }
    }
}

#Preview {
    ProfileView()
}
