//
//  BarracasView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI
import CoreData

struct FeirasView: View {
    
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
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(0 ..< vm.feirantes.count, id: \.self) { i in
                        NavigationLink {
                            FullFeiraView(f: i)
                        } label: {
                            if vm.feirantesLoaded{
                                BarracaCard(nome: vm.feirantes[i].nomeBanca,descricao: vm.feirantes[i].descricao)
                            }
                        }
                    }
                    if vm.feirantesLoaded == false{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                    }
                }
            }
            .onAppear{
                vm.produtosLoaded = false
                vm.pedidosLoaded = false
            }
            .refreshable(action: {
                vm.feirantesLoaded = false
                vm.fetchFeirantes() { success in
                    if success {
                        vm.pedidosLoaded = true
                    }
                }
            })
            .navigationTitle("Feiras")
        }
        
    }
}

#Preview {
    FeirasView(context: DataController().container.viewContext)
        .environmentObject(ViewModel())
}
