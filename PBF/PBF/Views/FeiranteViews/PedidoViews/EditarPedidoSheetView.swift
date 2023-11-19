//
//  EditarPedidoView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 17/11/23.
//

import SwiftUI
import CoreData

struct EditarPedidoSheetView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var pedido: Pedido
    
    @State var statusOptions = ["Em preparo", "Pronto", "Entregue"]
    
    //Coisa do CoreData
    @Environment(\.managedObjectContext) var context //Contexto, DataController
    
    //Coisas do MyDataController
    @ObservedObject var myDataController: MyDataController //acessar funcoes do meu CoreData
    
    @FetchRequest(sortDescriptors: []) var feiranteData: FetchedResults<FeiranteData> //Receber os dados salvos no CoreData
    @FetchRequest(sortDescriptors: []) var clienteData: FetchedResults<ClienteData> //Receber os dados salvos no CoreData
    
    init(context: NSManagedObjectContext, pedido: Binding<Pedido>) {
        self.myDataController = MyDataController(context: context)
        self._pedido = pedido
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                VStack{
                    Picker("Status", selection: $pedido.estado) {
                        ForEach(0 ..< 3) {
                            Text(self.statusOptions[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Text("Status selecionado: \(statusOptions[pedido.estado])")
                    
                    
                }
                VStack(alignment:.leading){
                    Text("Perfil do cliente:")
                        .font(.title)
                        .bold()
                        .padding()
                        .multilineTextAlignment(.leading)
                    Group{
                        HStack{
                            Text("\(vm.clienteAtual.nome == "" ? "Erro ao mostrar o nome" : vm.clienteAtual.nome)")
                                .font(.system(size:24))
                                .bold()
                            Spacer()
                        }
                        Group{
                            Text("Prédio: \(vm.clienteAtual.predio == "" ? "Essa conta ainda não possui um prédio registrado" : vm.clienteAtual.predio)")
                            
                            Text("Apartamento: \(vm.clienteAtual.apartamento == "" ? "Essa conta ainda não tem apartamento registrado" : vm.clienteAtual.apartamento)")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.vertical,3)
                    Spacer()
                }
            }
            
            .navigationTitle("Editar estado")
            .navigationBarItems(leading: Button("Cancelar") { dismiss() })
            .navigationBarItems(trailing:
                                    Button("Salvar") {
                // Chamando a função editarPedido
                vm.editarPedido(pedido: pedido) { success in
                    if success{
                        vm.fetchPedidosDoFeirante(feiranteId: vm.feiranteAtual.id ?? ""){ success2 in
                            if success2{
                                dismiss()
                            }
                            else{
                                print("Falha ao pegar os pedidos do feirante!")
                            }
                        }
                    }else{
                        print("Falha ao atualizar o pedido")
                    }
                }
            }
            )
        }
    }
}

#Preview {
    EditarPedidoSheetView(context: DataController().container.viewContext ,pedido: .constant(ViewModel().pedidosFeirante[0]))
        .environmentObject(ViewModel())
}
