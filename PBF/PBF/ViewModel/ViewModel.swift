//
//  ViewModel.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 11/10/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class ViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    
    @Published var feiranteAtualEmail: String = "zerado"
    @Published var clienteAtualEmail: String = "zerado"
    @Published var produtos: [Produto] = [Produto(nome:"Atum", preco: "13,00", quantidade: 3, descricao: "Atum do bom", feiranteEmail: "")]
    
    //Funções de Feirantes
    
    func fetchFeirantes(completion: @escaping ([Feirante]) -> ()) { //Funcao que retorna um vetor de todos os feirantes do meu banco de dados
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
    
    func fetchFeirante(email: String, completion: @escaping (Feirante?) -> Void) { //Funcao que retorna um feirante especifico baseado no email
        let db = Firestore.firestore()
        
        // Suponho que sua coleção seja chamada "feirantes"
        let feiranteRef = db.collection("feirantes").document(email)
        
        feiranteRef.getDocument { (document, error) in
            if let error = error {
                print("Erro ao buscar feirante: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let document = document, document.exists {
                do {
                    let feirante = try document.data(as: Feirante.self)
                    completion(feirante)
                } catch {
                    print("Erro ao decodificar feirante: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                print("Feirante não encontrado.")
                completion(nil)
            }
        }
    }
    
    func fetchProdutosDoFeirante(emailFeirante: String, completion: @escaping () -> Void) {  //Funcao que aplica nos self.produtos todos os produtos do feirante atual
            db.collection("produtos").whereField("feiranteEmail", isEqualTo: emailFeirante).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Erro ao buscar produtos: \(error.localizedDescription)")
                } else {
                    var produtosTemp: [Produto] = []
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let produto = Produto(
                            id: document.documentID,
                            nome: data["nome"] as! String,
                            preco: data["preço"] as! String,
                            quantidade: data["quantidade"] as! Int,
                            descricao: data["descricao"] as! String,
                            feiranteEmail: data["feiranteEmail"] as! String
                        )
                        produtosTemp.append(produto)
                    }
                    self.produtos = produtosTemp
                    completion()
                }
            }
        }
    
    
    func addFeirante(feirante: Feirante, completion: @escaping (Bool) -> Void) {
        // Primeiro, verifique se já existe um feirante com esse email
        fetchFeirante(email: feirante.email) { existingFeirante in
            // Se o feirante existir, retorne falso para a completion
            if existingFeirante != nil {
                print("Erro: Já existe um feirante com esse email.")
                completion(false)
            } else {
                // Caso contrário, prossiga com a adição do feirante
                let _ = self.db.collection("feirantes").addDocument(data: [
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
    
    func getSenhaFeirante(forID id: String, completion: @escaping (String?, Error?) -> Void) {
        db.collection("feirantes").document(id).getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let document = document, document.exists, let data = document.data(), let senha = data["senha"] as? String else {
                completion(nil, nil)
                return
            }
            
            completion(senha, nil)
        }
    }
    
    func getSenhaFeiranteWithEmail(email: String, completion: @escaping (String?, Error?) -> Void) {
        db.collection("feirantes")
            .whereField("email", isEqualTo: email)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let documents = querySnapshot?.documents, let firstDoc = documents.first else {
                    completion(nil, nil) // Email não encontrado
                    return
                }
                
                let senha = firstDoc.data()["senha"] as? String
                completion(senha, nil)
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
    func getSenhaClient(forID id: String, completion: @escaping (String?, Error?) -> Void) {
        db.collection("clientes").document(id).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let senha = data?["senha"] as? String
                completion(senha, nil)
            } else if let error = error {
                completion(nil, error)
            } else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Documento não encontrado."]))
            }
        }
    }
    
    func getSenhaClienteWithEmail(email: String, completion: @escaping (String?, Error?) -> Void) {
        db.collection("clientes")
            .whereField("email", isEqualTo: email)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let documents = querySnapshot?.documents, let firstDoc = documents.first else {
                    completion(nil, nil) // Email não encontrado
                    return
                }
                
                let senha = firstDoc.data()["senha"] as? String
                completion(senha, nil)
            }
    }
    
    //Funções Produtos ----------------------------------------------------------
    
    func criarProduto(product: Produto, completion: @escaping (Error?) -> Void) {
        var newProduct = product
        if newProduct.id == nil {
            newProduct.id = UUID().uuidString
        }
        
        db.collection("produtos").document(newProduct.id!).setData(newProduct.toAnyObject() as! [String : Any]) { error in
            completion(error)
        }
    }
    
    func editarProduto(nomeOriginal: String, novoProduto: Produto, completion: @escaping (Bool) -> ()) {
        
        // Acessando a coleção de produtos
        let produtosRef = db.collection("produtos")
        
        // Consulta para encontrar o produto pelo seu nome
        produtosRef.whereField("nome", isEqualTo: nomeOriginal).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Erro ao buscar produto: \(err.localizedDescription)")
                completion(false)
                return
            }
            
            // Se o produto for encontrado, atualizamos com os novos detalhes
            for document in querySnapshot!.documents {
                let docID = document.documentID
                produtosRef.document(docID).setData(novoProduto.toAnyObject() as! [String: Any]) { err in
                    if let err = err {
                        print("Erro ao atualizar produto: \(err.localizedDescription)")
                        completion(false)
                    } else {
                        print("Produto atualizado com sucesso.")
                        completion(true)
                    }
                }
            }
        }
    }
    
}
