//
//  TabView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 23/10/23.
//

import SwiftUI
import CoreData

struct HomeViewFeirante: View {
    
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
            PedidosView()
                .tabItem {
                    Label("Pedidos", systemImage: "list.clipboard")
                }
            
            ItensView(context: context)
                .tabItem {
                    Label("Itens", systemImage: "cart")
                }
            
            PerfilFeiranteView(context: context)
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }
        }
    }
}

#Preview {
    HomeViewFeirante(context: DataController().container.viewContext)
}
