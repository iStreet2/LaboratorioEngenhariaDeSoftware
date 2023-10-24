//
//  CreateFeiranteAccountView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 23/10/23.
//

import SwiftUI
import CoreData

struct CreateFeiranteAccountView: View {
    @State var nameInput: String = ""
    @State var emailInput: String = ""
    @State var cpfInput: String = ""
    @State var passInput: String = ""
    
    @State var navigate = false
    
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
        NavigationView{
            ScrollView{
                VStack{
                    VStack(alignment: .leading){
                        Text("Nome")
                            .foregroundStyle(.gray)
                        TextField("", text: $nameInput)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        Text("Email")
                            .foregroundStyle(.gray)
                        TextField("", text: $emailInput)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        Text("CPF/CNPJ")
                            .foregroundStyle(.gray)
                        TextField("", text: $emailInput)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        Text("Senha")
                            .foregroundStyle(.gray)
                        TextField("", text: $passInput)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                    }
                    .padding()
                    Spacer()
                    VStack{
                        NavigationLink("Criar Conta"){
                            ContentView()
                                .navigationBarBackButtonHidden(true)
                                .onAppear{ //Salvar dados no banco de dados
                                    let feirante = Feirante(_) //PAREI AQUI, ONDE TENHO QUE CRIAR UMA VARIAVEL COM A INSTANCIA DO MEU FEIRANTE PARA CHAMAR A FUNCAO DA VIEWMODEL ADDFEIRANTE E MANDAR ELE PRO BANCO DE DADOS :)
                                }
                        }
                        .buttonStyle(PBFButtonSyle())
                    }
                    Spacer()
                }
                
                .navigationTitle("Feirante")
            }
        }
    }
}

#Preview {
    CreateFeiranteAccountView(context: DataController().container.viewContext)
}
