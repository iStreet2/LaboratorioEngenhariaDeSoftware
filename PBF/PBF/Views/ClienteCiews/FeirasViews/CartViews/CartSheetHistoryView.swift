//
//  CartSheetHistoryView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 16/11/23.
//

import SwiftUI

struct CartSheetHistoryView: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    ForEach(0 ..< vm.pedidosCliente.count, id: \.self){ i in
                        if vm.pedidosCliente[i].estado == 3 {
                            PedidoView(nome: vm.pedidosCliente[i].produtoNome, estado: vm.pedidosCliente[i].estado, quantidade: vm.pedidosCliente[i].quantidade)
                        }
                    }
                }
            }
            .navigationTitle("Histórico")
        }
    }
}

#Preview {
    CartSheetHistoryView()
        .environmentObject(ViewModel())
}
