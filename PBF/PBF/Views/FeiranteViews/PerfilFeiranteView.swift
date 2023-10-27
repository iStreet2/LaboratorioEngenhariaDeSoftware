//
//  PerfilFeiranteView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI
import CoreData

struct PerfilFeiranteView: View {
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
                VStack {
                    Button {
                        myDataController.deleteAllFeiranteData()
                    } label: {
                        Text("Esquecer Login")
                    }
                }
            }
            .navigationTitle("Perfil")
        }
        

    }
}

#Preview {
    PerfilFeiranteView(context: DataController().container.viewContext)
}
