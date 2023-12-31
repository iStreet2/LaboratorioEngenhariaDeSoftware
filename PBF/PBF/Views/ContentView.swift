//
//  ChooseAccountView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var vm: ViewModel
    
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
        NavigationStack {
            VStack {
                Text("Por favor, selecione o tipo de conta que deseja realizar o login")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.gray)
                
                // MARK: Conectar com o Firebase
                // Botão para as views do feirante
                NavigationLink("Feirante"){
                    if myDataController.checkEmailFeirante(){ //Se eu ja tiver um email no CoreData, eu vou para a HomeView direto, se nao eu vou pro login
                        HomeViewFeirante(context: context)
                            .navigationBarBackButtonHidden(true)
                            .onAppear{
                                if let feiranteEmail = myDataController.getEmailFeirante() { //Coloco  meu feirante atual o que esta logando direto
                                    vm.fetchFeirante(email: feiranteEmail){ feirante in//Procuro no meu DataBase um feirante com o email que esta no coredata
                                        
                                        vm.feiranteAtual = feirante ?? vm.feiranteAtual //Aqui eu coloco meu feirante atual da ViewModel igual o feirante que eu achei no meu database baseado no email do CoreData
                                        
                                        vm.prepararFeirante() { _ in}
                                    }
                                    
                                } else {
                                    print("Nenhum email de feirante encontrado no CoreData.")
                                }
                            }
                    }else{
                        LoginFeiranteView(context: context)
                    }
                }
                .buttonStyle(PBFButtonSyle())
                
                // Botão para as views do cliente
                NavigationLink("Cliente"){
                    if myDataController.checkEmailCliente(){ //Mesma logica anterior
                        HomeViewCliente(context: context)
                            .navigationBarBackButtonHidden(true)
                            .onAppear{
                                if let clienteEmail = myDataController.getEmailCliente() {
                                    vm.fetchCliente(email: clienteEmail) { cliente in
                                        vm.clienteAtual = cliente ?? vm.clienteAtual //Defino meu cliente atual na viewModel o mesmo cliente que esta no meu banco de dados com o email salvo no CoreData

                                        vm.prepararCliente()
                                    }
                                } else {
                                    print("Nenhum email de feirante encontrado no CoreData.")
                                }
                            }
                    }else{
                        LoginClientView(context: context)
                    }
                }
                .buttonStyle(PBFButtonSyle())
            }
            .padding()
        }
        
    }
}


#Preview {
    ContentView(context: DataController().container.viewContext)
}

