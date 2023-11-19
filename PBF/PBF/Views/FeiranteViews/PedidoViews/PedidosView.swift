//
//  PedidosView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI
import CoreData

struct PedidosView: View {
    @EnvironmentObject var vm: ViewModel
    @State var sheet2 = false
    @State private var selectedPedido: Pedido = Pedido(produtoId: "", produtoNome: "", clienteId: "", feiranteId: "", quantidade: 13, observacao: "", estado: 0)    
    
    //Coisa do CoreData
    @Environment(\.managedObjectContext) var context //Contexto, DataController
    
    //Coisas do MyDataController
    @ObservedObject var myDataController: MyDataController //acessar funcoes do meu CoreData
    
    @FetchRequest(sortDescriptors: []) var feiranteData: FetchedResults<FeiranteData> //Receber os dados salvos no CoreData
    @FetchRequest(sortDescriptors: []) var clienteData: FetchedResults<ClienteData> //Receber os dados salvos no CoreData
    
    init(context: NSManagedObjectContext) {
        self.myDataController = MyDataController(context: context)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    ForEach(0 ..< vm.pedidosFeirante.count, id: \.self){ i in
                        if vm.pedidosFeiranteLoaded {
                            Button(action: {
                                selectedPedido = vm.pedidosFeirante[i]
                                vm.clienteAtual = vm.clientesParaOsFeirantes[i]
                                sheet2.toggle()
                            }, label: {
                                if vm.pedidosFeirante[i].estado != 3{
                                    PedidoView(pedido: vm.pedidosFeirante[i], cliente: vm.clientesParaOsFeirantes[i], feirante: vm.feiranteAtual, tipo: 1)
                                        .foregroundColor(.black)
                                }
                            })
                            .sheet(isPresented: $sheet2){
                                EditarPedidoSheetView(context: context,pedido: $selectedPedido)
                            }.onAppear{
                                print("\(vm.clientesParaOsFeirantes[i])")
                            }
                        }
                    }
                    if !vm.pedidosFeiranteLoaded{
                        ProgressView()
                    }else if vm.pedidosFeirante.count < 1{
                        Text("Não há pedidos no momento!")
                    }
                }
            }
            .refreshable(action: {
                vm.pedidosFeiranteLoaded = false
                vm.fetchPedidosDoFeirante(feiranteId: vm.feiranteAtual.id ?? "teste") { success in
                    if success {
                        vm.pedidosFeiranteLoaded = true
                        
                    }
                }
            })
            .navigationTitle("Pedidos")
            
        }
        
    }
}

#Preview {
    PedidosView(context: DataController().container.viewContext)
        .environmentObject(ViewModel())
}
