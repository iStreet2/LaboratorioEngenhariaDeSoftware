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
    @State var nomeBarraca: String = ""
    @State var descricaoBarraca: String = ""
    @State var tiposDeProduto: String = ""
    @State var errorMessage: String = ""
    
    //Variaveis para a animacao do botao
    @State private var isLoading = false
    @State private var isSuccess = false
    @State private var navigate = false
    
    
    
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
                        Text("Senha")
                            .foregroundStyle(.gray)
                        TextField("", text: $passInput)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        Text("Nome da Barraca")
                            .foregroundStyle(.gray)
                        TextField("", text: $nomeBarraca)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        Text("Descrição da barraca")
                            .foregroundStyle(.gray)
                        TextField("", text: $descricaoBarraca)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        Text("Tipos de produto")
                            .foregroundStyle(.gray)
                        TextField("", text: $tiposDeProduto)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        
                    }
                    .padding()
                    Spacer()
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    VStack{
                        VStack {
                            if !isLoading {
                                Button("Criar Conta") {
                                    
                                    if emailInput.isEmpty || passInput.isEmpty {
                                        // Configura a mensagem de erro
                                        errorMessage = "Por favor, preencha todos os campos."
                                        return // Sai da função para evitar que o resto do código seja executado
                                    }
                                    errorMessage = ""
                                    
                                    withAnimation {
                                        isLoading = true
                                    }
                                    
                                    let feirante = Feirante(nome: nameInput, email: emailInput, telefone: "", senha: passInput, nomeBanca: nomeBarraca, tiposDeProduto: tiposDeProduto, descricao: descricaoBarraca)
                                    
                                    vm.feiranteAtual = feirante
                                                                        
                                    vm.addFeirante(feirante: feirante) { success in
                                        if success {
                                            withAnimation {
                                                isSuccess = true
                                            }
                                            vm.fetchFeirante(email: emailInput){ feiranteComId in
                                                vm.feiranteAtual = feiranteComId ?? vm.feiranteAtual
                                                vm.prepararFeirante(){ _ in}
                                            }
                                        } else {
                                            withAnimation {
                                                isLoading = false
                                            }
                                        }
                                    }
                                    
                                    
                                    
                                    
                                }
                                .buttonStyle(PBFButtonSyle())
                            }
                            
                            if isLoading {
                                if isSuccess {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.green)
                                        .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                withAnimation {
                                                    navigate = true
                                                }
                                            }
                                        }
                                } else {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                                        .scaleEffect(1.5)
                                }
                            }
                        }
                        
                        NavigationLink("", destination: HomeViewFeirante(context: context).navigationBarBackButtonHidden(true), isActive: $navigate)
                            .hidden()
                        
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
