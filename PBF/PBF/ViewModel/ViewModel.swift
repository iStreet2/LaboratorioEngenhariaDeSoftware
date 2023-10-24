//
//  ViewModel.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 11/10/23.
//

import Foundation
import FirebaseFirestore

class ViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    
    
    
    //Funções de Feirantes
    
    func fetchFeirantes(completion: @escaping ([Feirante]) -> ()) {
        db.collection("feirantes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Erro ao obter feirantes: \(err)")
            } else {
                var feirantes: [Feirante] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let feirante = Feirante(
                        id: document.documentID,
                        nome: data["nome"] as! String,
                        email: data["email"] as! String,
                        telefone: data["telefone"] as! String,
                        senha: data["senha"] as! String,
                        nomeBanca: data["nomeBanca"] as! String,
                        tiposDeProduto: data["tiposDeProduto"] as! String,
                        descricao: data["descricao"] as! String)
                    feirantes.append(feirante)
                }
                completion(feirantes)
            }
        }
    }
    
    func addFeirante(feirante: Feirante, completion: @escaping (Bool) -> Void) {
        let _ = db.collection("feirantes").addDocument(data: [
            "nome": feirante.nome,
            "email": feirante.email,
            "telefone": feirante.telefone,
            "senha": feirante.senha,
            "nomeBanca": feirante.nomeBanca,
            "tiposDeProduto": feirante.tiposDeProduto,
            "descricao": feirante.descricao
        ]) { err in
            if let err = err {
                print("Erro ao adicionar o feirante: \(err.localizedDescription)")
                completion(false)
            } else {
                print("Feirante adicionado com sucesso.")
                completion(true)
            }
        }
    }

    
    func deleteFeirante(id: String) {
        db.collection("feirantes").document(id).delete() { err in
            if let err = err {
                print("Erro ao remover o feirante: \(err.localizedDescription)")
            } else {
                print("Feirante removido com sucesso.")
            }
        }
    }
    
    func getFeiranteID(email: String, completion: @escaping (String?) -> Void) {
        db.collection("feirantes").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
            if let err = error {
                print("Erro ao obter o feirante: \(err.localizedDescription)")
                completion(nil)
                return
            }
            
            if let document = snapshot?.documents.first {
                let feiranteID = document.documentID
                completion(feiranteID)
            } else {
                print("Nenhum feirante encontrado com o email fornecido.")
                completion(nil)
            }
        }
    }
    
    
    //--------------------------------------------------------------------------------------------------------------
    //Funções de Clientes
    
    
    func fetchClientes(completion: @escaping ([Cliente]) -> ()) {
        db.collection("clientes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Erro ao obter clientes: \(err)")
            } else {
                var clientes: [Cliente] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let cliente = Cliente(
                        id: document.documentID,
                        nome: data["nome"] as! String,
                        email: data["email"] as! String,
                        telefone: data["telefone"] as! String,
                        senha: data["senha"] as! String,
                        predio: data["predio"] as! String,
                        apartamento: data["apartamento"] as! String)
                    clientes.append(cliente)
                }
                completion(clientes)
            }
        }
    }
    
    func addCliente(cliente: Cliente, completion: @escaping (Bool) -> Void) {
        let _ = db.collection("clientes").addDocument(data: [
            "nome": cliente.nome,
            "email": cliente.email,
            "telefone": cliente.telefone,
            "senha": cliente.senha,
            "predio": cliente.predio,
            "apartamento": cliente.apartamento
        ]) { err in
            if let err = err {
                print("Erro ao adicionar o cliente: \(err.localizedDescription)")
                completion(false)
            } else {
                print("Cliente adicionado com sucesso.")
                completion(true)
            }
        }
    }

    
    func deleteCliente(id: String) {
        db.collection("clientes").document(id).delete() { err in
            if let err = err {
                print("Erro ao remover o cliente: \(err.localizedDescription)")
            } else {
                print("Cliente removido com sucesso.")
            }
        }
    }
    
    func getClientID(email: String, completion: @escaping (String?) -> Void) {
        db.collection("clientes").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
            if let err = error {
                print("Erro ao obter o cliente: \(err.localizedDescription)")
                completion(nil)
                return
            }
            
            if let document = snapshot?.documents.first {
                let clienteID = document.documentID
                completion(clienteID)
            } else {
                print("Nenhum cliente encontrado com o email fornecido.")
                completion(nil)
            }
        }
    }
    
}
