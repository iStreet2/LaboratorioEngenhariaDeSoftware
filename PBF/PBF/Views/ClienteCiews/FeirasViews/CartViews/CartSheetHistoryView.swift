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
                        if vm.pedidosCliente[i].estado == 2 {
                            PedidoView(pedido: vm.pedidosCliente[i], cliente: vm.clienteAtual, feirante: vm.feirantesParaOsCliente[i], tipo: 0)
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
