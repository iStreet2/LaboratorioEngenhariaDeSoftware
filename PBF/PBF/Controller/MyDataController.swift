//
//  CoreDataController.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 23/10/23.
//

import Foundation
import CoreData


class MyDataController: ObservableObject{
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        
    }
    
    func saveContext() {
        do{
            try context.save()
        } catch{
            print("Não foi possível salvar os dados")
        }
    }
    
    func checkEmailFeirante() -> Bool{ //Checar se a pessoa ja tem um email salvo para entrar direto no App
        let amountCoreDataItems = try? context.count(for: FeiranteData.fetchRequest())
        
        guard amountCoreDataItems == 0 else{
            //tem um email, entao retorna true, para dizer que tem um email registrado
            return true
        }
        //nao tem nenhum email registrado no app, entao retorna falso
        return false
    }
    
    func checkEmailCliente() -> Bool{ //Checar se a pessoa ja tem um email salvo para entrar direto no App
        let amountCoreDataItems = try? context.count(for: ClienteData.fetchRequest())
        
        guard amountCoreDataItems == 0 else{
            //tem um email, entao retorna true, para dizer que tem um email registrado
            return true
        }
        //nao tem nenhum email registrado no app, entao retorna falso
        return false
    }
    
    
    func saveLoginFeirante(id: String, email: String){
        let feiranteData = FeiranteData(context: context)
        feiranteData.email = email
        feiranteData.id = id
        saveContext()
    }
    
    func saveLoginCliente(id: String, email: String){
        let clienteData = ClienteData(context: context)
        clienteData.email = email
        clienteData.id = id
        saveContext()
    }
}
