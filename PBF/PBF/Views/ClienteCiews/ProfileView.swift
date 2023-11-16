//
//  ProfileView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    
    @State var navigation = false
    
    @EnvironmentObject var vm: ViewModel
    
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
                VStack (alignment:.leading){
                    Group{
                        Text("\(vm.clienteAtual.nome == "" ? "Erro ao mostrar o nome" : vm.clienteAtual.nome)")
                            .font(.system(size:24))
                            .bold()
                        Group{
                            Text("Nome da barra: \(vm.feiranteAtual.nomeBanca == "" ? "Sua barraca ainda não possui um nome" : vm.feiranteAtual.nomeBanca )")
                            
                            Text("Descrição: \(vm.feiranteAtual.descricao == "" ? "Sua barraca ainda não tem descrição" : vm.feiranteAtual.descricao)")
                                .font(.system(size: 16))
                            
                        }
                        .foregroundColor(.gray)
                    }
                    .padding(.vertical,5)
                }
                .padding()
                
                Button {
                    myDataController.deleteAllClienteData()
                    navigation.toggle()
                } label: {
                    Text("Esquecer Login")
                }
                NavigationLink("", destination: ContentView(context: context).navigationBarBackButtonHidden(true), isActive: $navigation)
                    .hidden()
            }
            .navigationTitle("Perfil")
            .onAppear{
                vm.pedidosLoaded = false
            }
        }
        
    }
}


#Preview {
    ProfileView(context: DataController().container.viewContext)
        .environmentObject(ViewModel())
}
