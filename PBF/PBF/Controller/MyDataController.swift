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
    
    //Métodos Feirantes
    
    func checkEmailFeirante() -> Bool{ //Checar se a pessoa ja tem um email salvo para entrar direto no App
        let amountCoreDataItems = try? context.count(for: FeiranteData.fetchRequest())
        
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
    
    func getEmailFeirante() -> String?{
        let fetchRequest: NSFetchRequest<FeiranteData> = FeiranteData.fetchRequest()
        
        do {
            let feirantes = try context.fetch(fetchRequest)
            
            // Retorna o e-mail do primeiro feirante encontrado.
            if let feirante = feirantes.first {
                return feirante.email
            } else {
                // Se não encontrar nenhum feirante, retorna nil.
                return nil
            }
            
        } catch {
            print("Erro ao buscar e-mail do feirante: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteAllFeiranteData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FeiranteData.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            saveContext()
            print("Todos os dados de Feirante foram deletados.")
        } catch {
            print("Erro ao deletar todos os dados de Feirante: \(error.localizedDescription)")
        }
    }
    
    
    //Métodos Cliente
    
    func checkEmailCliente() -> Bool{ //Checar se a pessoa ja tem um email salvo para entrar direto no App
        let amountCoreDataItems = try? context.count(for: ClienteData.fetchRequest())
        
        guard amountCoreDataItems == 0 else{
            //tem um email, entao retorna true, para dizer que tem um email registrado
            return true
        }
        //nao tem nenhum email registrado no app, entao retorna falso
        return false
    }
    
    func saveLoginCliente(id: String, email: String){
        let clienteData = ClienteData(context: context)
        clienteData.email = email
        clienteData.id = id
        saveContext()
    }

    func deleteAllClienteData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ClienteData.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            saveContext()
            print("Todos os dados de Cliente foram deletados.")
        } catch {
            print("Erro ao deletar todos os dados de Cliente: \(error.localizedDescription)")
        }
    }
    
    func getEmailCliente() -> String?{
        let fetchRequest: NSFetchRequest<ClienteData> = ClienteData.fetchRequest()
        
        do {
            let clientes = try context.fetch(fetchRequest)
            
            // Retorna o e-mail do primeiro feirante encontrado.
            if let cliente = clientes.first {
                return cliente.email
            } else {
                // Se não encontrar nenhum feirante, retorna nil.
                return nil
            }
            
        } catch {
            print("Erro ao buscar e-mail do cliente: \(error.localizedDescription)")
            return nil
        }
    }

}
