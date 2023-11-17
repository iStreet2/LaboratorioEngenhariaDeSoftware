//
//  CartSheetHistoryView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 16/11/23.
//

import SwiftUI

struct CartSheetHistoryView: View {
    @EnvironmentObject var vm: ViewModel
    @State var feirante: Feirante = Feirante(nome: "", email: "", telefone: "", senha: "", nomeBanca: "", tiposDeProduto: "", descricao: "")
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    ForEach(0 ..< vm.pedidosCliente.count, id: \.self){ i in
                        if vm.pedidosCliente[i].estado == 3 {
                            PedidoView(nome: vm.pedidosCliente[i].produtoNome, estado: vm.pedidosCliente[i].estado, quantidade: vm.pedidosCliente[i].quantidade, nomeCliente: vm.clienteAtual.nome,nomeFeirante: feirante.nome, tipo: 0)
                                .onAppear{
                                    vm.fetchFeiranteWithId(id: vm.pedidosCliente[i].feiranteId) { feirante in
                                        self.feirante = feirante ?? self.feirante
                                    }
                                }
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
