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
                        
                        //ARRUMAR DE PEGAR O EMAIL DO CORE DATA E COLOCAR NO EMAIL ATUAL DA VIEWLMODEL
                        if let feiranteEmail = myDataController.getEmailFeirante() {
                            vm.feiranteAtualEmail = feiranteEmail
                        } else {
                            print("Nenhum email de feirante encontrado no CoreData.")
                        }
                                                
                        HomeViewFeirante(context: context)
                            .navigationBarBackButtonHidden(true)
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

