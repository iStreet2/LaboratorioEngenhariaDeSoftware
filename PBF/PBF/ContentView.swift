//
//  ContentView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 13/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Esse vai ser o app de bolsa familia mais pika de todos")
                .multilineTextAlignment(.center)
            Text( "Pode ter certeza!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
