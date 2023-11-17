//
//  PerfilFeiranteView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI
import CoreData

struct PerfilFeiranteView: View {
    @State var navigation = false
    @State var isShowingSheet = false
    
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
                VStack() {
                    VStack(alignment:.leading){
                        Group{
                            HStack{
                                Text(vm.feiranteAtual.nome)
                                    .font(.system(size:24))
                                    .bold()
                                Spacer()
                            }
                            Group{
                                Text("Nome da barra: \(vm.feiranteAtual.nomeBanca == "" ? "Sua barraca ainda não possui um nome" : vm.feiranteAtual.nomeBanca )")
                                
                                Text("Descrição: \(vm.feiranteAtual.descricao == "" ? "Sua barraca ainda não tem descrição" : vm.feiranteAtual.descricao)")
                                    .font(.system(size: 16))
                                
                            }
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                        }
                        .padding(.vertical,5)
                    }
                    .padding()
                    
                    Button {
                        myDataController.deleteAllFeiranteData()
                        navigation.toggle()
                    } label: {
                        Text("Esquecer Login")
                    }
                    .padding()
                    NavigationLink("", destination: ContentView(context: context).navigationBarBackButtonHidden(true), isActive: $navigation)
                        .hidden()
                }
            }
            .navigationTitle("Perfil")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingSheet.toggle()
                    }) {
                        Text("Editar")
                    }
                }
            }
            .sheet(isPresented: $isShowingSheet) {
                EditPerfilFeiranteView()
            }
            
        }
        
        
        
    }
}

#Preview {
    PerfilFeiranteView(context: DataController().container.viewContext)
        .environmentObject(ViewModel())
}
