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
    @State var sheet = false
    
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
                        HStack{
                            Text("\(vm.clienteAtual.nome == "" ? "Erro ao mostrar o nome" : vm.clienteAtual.nome)")
                                .font(.system(size:24))
                                .bold()
                            Spacer()
                        }
                        Group{
                            Text("Prédio: \(vm.clienteAtual.predio == "" ? "Sua conta ainda não possui um prédio registrado" : vm.clienteAtual.predio)")
                            
                            Text("Apartamento: \(vm.clienteAtual.apartamento == "" ? "Sua conta ainda não tem apartamento registrado" : vm.clienteAtual.apartamento)")
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
                vm.pedidosClienteLoaded = false
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        sheet.toggle()
                    }) {
                        Text("Editar")
                    }
                }
            }
            .sheet(isPresented: $sheet) {
                EditarPerfilClienteView()
            }
        }
        
    }
}


#Preview {
    ProfileView(context: DataController().container.viewContext)
        .environmentObject(ViewModel())
}
