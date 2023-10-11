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
    
    func addCliente(cliente: Cliente) {
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
            } else {
                print("Cliente adicionado com sucesso.")
            }
        }
    }
    
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
    
    func deleteCliente(id: String) {
            db.collection("clientes").document(id).delete() { err in
                if let err = err {
                    print("Erro ao remover o cliente: \(err.localizedDescription)")
                } else {
                    print("Cliente removido com sucesso.")
                }
            }
        }
    
}
