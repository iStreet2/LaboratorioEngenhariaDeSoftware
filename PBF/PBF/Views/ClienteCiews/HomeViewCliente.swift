//
//  TabView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 23/10/23.
//

import SwiftUI
import CoreData

struct HomeViewCliente: View {
    
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
        TabView {
            FeirasView(context: context)
                .tabItem {
                    Label("Feiras", systemImage: "storefront")
                }
            
            CartView()
                .tabItem {
                    Label("Carrinho", systemImage: "cart")
                }
            
            ProfileView(context: context)
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }
        }
        
    }
}

#Preview {
    HomeViewCliente(context: DataController().container.viewContext)
        .environmentObject(ViewModel())
}
