//
//  LoginFeiranteView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI
import CoreData

struct LoginFeiranteView: View {
    @State var loginInput: String = ""
    @State var passwordInput: String = ""
    
    //Variaveis para a animacao do botao
    @State private var isLoading = false
    @State private var isSuccess = false
    @State private var navigate = false
    @State private var wrongPass = false
    
    @State private var keepMeLoggedIn = false
    
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
            VStack(spacing: 20) {
                Spacer()
                // Login
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email")
                        .foregroundStyle(.gray)
                    TextField("", text: $loginInput)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                    
                    // Senha
                    HStack{
                        Text("Senha")
                            .foregroundStyle(.gray)
                        if wrongPass{
                            Text("Senha incorreta!")
                                .foregroundColor(.red)
                        }
                    }
                    TextField("", text: $passwordInput)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                    
                    
                    //Botão para criar uma conta
                    NavigationLink() {
                        CreateFeiranteAccountView(context: context)
                    } label: {
                        Text("Criar conta")
                            .foregroundColor(.gray)
                            .underline()
                            .font(.system(size:13))
                    }
                    
                    Toggle(isOn: $keepMeLoggedIn) {
                        Text("Mantenha-me conectado")
                    }
                    .toggleStyle(CheckboxStyle())
                    .padding(.top)
                    
                }
                if !isLoading {
                    Button("Login") {
                        withAnimation {
                            isLoading = true
                        }
                        
                        vm.getSenhaFeiranteWithEmail(email: loginInput) { senha, error in
                            if let error = error {
                                print("Ocorreu um erro ao obter a senha: \(error.localizedDescription)")
                                withAnimation {
                                    isLoading = false
                                }
                                return
                            }
                            
                            if senha == passwordInput {
                                print("Login bem-sucedido!")
                                withAnimation {
                                    isSuccess = true
                                    wrongPass = false
                                    vm.fetchFeirante(email:loginInput){feirante in
                                        vm.feiranteAtual = feirante ?? vm.feiranteAtual
                                        vm.prepararFeirante()
                                    }
                                }
                                
                                vm.getFeiranteID(email: loginInput) { feiranteID in
                                    if let id = feiranteID {
                                        // Salvar os detalhes no CoreData
                                        if keepMeLoggedIn {
                                            myDataController.saveLoginFeirante(id: id, email: loginInput)
                                        }
                                    } else {
                                        print("Não foi possível obter o ID do feirante.")
                                    }
                                }
                            }
                            
                            
                            else {
                                print("Senha incorreta ou Feirante não encontrado.")
                                withAnimation {
                                    isLoading = false
                                    wrongPass = true
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
                
                NavigationLink("", destination: HomeViewFeirante(context: context).navigationBarBackButtonHidden(true), isActive: $navigate)
                    .hidden()
                
                Spacer()
                
            }
            .padding()
        }
    }
}

#Preview {
    LoginFeiranteView(context: DataController().container.viewContext)
}
