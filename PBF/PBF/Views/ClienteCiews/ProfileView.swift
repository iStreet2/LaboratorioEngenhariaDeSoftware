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
        NavigationStack {
            ScrollView {
                VStack {
                    Button {
                        myDataController.deleteAllClienteData()
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
        }
        
        
    }
}

#Preview {
    ProfileView(context: DataController().container.viewContext)
}
