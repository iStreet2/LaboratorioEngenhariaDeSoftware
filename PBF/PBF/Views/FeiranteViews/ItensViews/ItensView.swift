//
//  ItensView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI
import CoreData

struct ItensView: View {
    
    @State private var isShowingSheet = false
    
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
    
    // Definindo o layout das colunas
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0 ..< vm.produtos.count, id: \.self) { i in
                        NavigationLink {
                            FullItemView(i: i)
                        } label: {
                            ItemView(titulo: vm.produtos[i].nome, preco: vm.produtos[i].preco, quantidade: vm.produtos[i].quantidade)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Itens")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingSheet) {
                AddItemSheetView()
            }
            
        }
    }
}

#Preview {
    ItensView(context: DataController().container.viewContext)
        .environmentObject(ViewModel())
}
