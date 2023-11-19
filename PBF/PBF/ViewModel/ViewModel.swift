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
    
    //Variáveis de feirante
    @Published var feiranteAtual: Feirante = Feirante(id: "eIGpjCOj6Qdmk0N0zk7o", nome: "Paulo", email: "", telefone: "", senha: "", nomeBanca: "Barraca do Paulo", tiposDeProduto: "", descricao: "Uma barraca humilde")
    @Published var pedidosFeirante: [Pedido] = [Pedido(produtoId: "4F054D8E-67DD-47EA-9A4E-8D6C1691BE0B", produtoNome: "Espetinho de Chocolate", clienteId: "teste", feiranteId: "", quantidade: 1, observacao: "Bem doce!", estado: 0)]
    @Published var pedidosFeiranteLoaded = false
    @Published var clientesParaOsFeirantes:[Cliente] = [Cliente(nome: "Sabrina", email: "", telefone: "", senha: "", predio: "", apartamento: "")] //Variável para armazenar os clientes que fizeram pedidos, vai ser utilizada na PedidosView
    
    //Variáveis do cliente
    @Published var clienteAtual: Cliente = Cliente(nome: "Sabrina", email: "", telefone: "", senha: "", predio: "Boa Vista", apartamento: "104")
    @Published var feirantes: [Feirante] = [Feirante(nome: "Jorge", email: "a", telefone: "11 912345678", senha: "", nomeBanca: "Barraca do Seu Jorge", tiposDeProduto: "", descricao: "A melhor barraca que você encontrará por aqui! Alguma coisa para o texto"),Feirante(nome: "Jorge", email: "jorge@gmail.com", telefone: "11 912345678", senha: "", nomeBanca: "Barraca do Seu Jorge", tiposDeProduto: "", descricao: "A melhor barraca que você encontrará por aqui!"),Feirante(nome: "Jorge", email: "jorge@gmail.com", telefone: "11 912345678", senha: "", nomeBanca: "Barraca do Seu Jorge", tiposDeProduto: "", descricao: "A melhor barraca que você encontrará por aqui!"),Feirante(nome: "Jorge", email: "jorge@gmail.com", telefone: "11 912345678", senha: "", nomeBanca: "Barraca do Seu Jorge", tiposDeProduto: "", descricao: "A melhor barraca que você encontrará por aqui!")]
    @Published var feirantesLoaded = false
    @Published var produtosLoaded = false
    @Published var pedidosClienteLoaded = false
    @Published var pedidosCliente: [Pedido] = [Pedido(produtoId: "0CC30D37-2411-48C1-9510-887F761ED2E3", produtoNome: "Espetinho de Chocolate", clienteId: "teste", feiranteId: "", quantidade: 1, observacao: "Bem doce!", estado: 0)]
    @Published var feirantesParaOsCliente:[Feirante] = [] //Variável para armazenar os clientes que fizeram pedidos, vai ser utilizada na CartView
    
    //Variáveis para os dois
    @Published var produtos: [Produto] = [Produto(nome:"", preco: "", quantidade: 1, descricao: "", feiranteEmail: "")]
    
    
    //Funções de Feirantes
    
    func fetchFeirantes(completion: @escaping (Bool) -> Void) { //Pega todos os feirantes do meu banco de dados e coloca no meu vetor da ViewModel feirantes
        db.collection("feirantes").getDocuments() { [weak self] (querySnapshot, err) in
            if let err = err {
                print("Erro ao obter feirantes: \(err)")
                completion(false)
            } else {
                var feirantesTemp: [Feirante] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let feirante = Feirante(
                        id: document.documentID,
                        nome: data["nome"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        telefone: data["telefone"] as? String ?? "",
                        senha: data["senha"] as? String ?? "",
                        nomeBanca: data["nomeBanca"] as? String ?? "",
                        tiposDeProduto: data["tiposDeProduto"] as? String ?? "",
                        descricao: data["descricao"] as? String ?? "")
                    feirantesTemp.append(feirante)
                }
                DispatchQueue.main.async {
                    self?.feirantes = feirantesTemp
                    completion(true)
                }
            }
        }
    }
    
    
    func fetchFeirante(email: String, completion: @escaping (Feirante?) -> Void) {
        db.collection("feirantes").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Erro ao buscar feirante: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let document = querySnapshot?.documents.first else {
                print("Feirante não encontrado.")
                completion(nil)
                return
            }
            
            do {
                var feirante = try document.data(as: Feirante.self)
                feirante.id = document.documentID
                completion(feirante)
            } catch {
                print("Erro ao decodificar feirante: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func fetchFeiranteWithId(id: String, completion: @escaping (Feirante?) -> Void) {
        db.collection("feirantes").document(id).getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Erro ao buscar feirante: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists else {
                print("Feirante não encontrado.")
                completion(nil)
                return
            }

            do {
                var feirante = try documentSnapshot.data(as: Feirante.self)
                feirante.id = documentSnapshot.documentID // Adiciona o id ao feirante
                completion(feirante)
            } catch {
                print("Erro ao decodificar feirante: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    
    func fetchProdutosDoFeirante(emailFeirante: String, completion: @escaping (Bool) -> Void) {  //Funcao que aplica nos self.produtos todos os produtos do feirante atual
        self.produtos = []
        db.collection("produtos").whereField("feiranteEmail", isEqualTo: emailFeirante).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Erro ao buscar produtos: \(error.localizedDescription)")
                completion(false)
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
                completion(true)
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
    
    func editarFeirante(feirante: Feirante, completion: @escaping (Bool) -> Void) {
        // Verifique se o ID do feirante está presente
        guard let feiranteId = feirante.id else {
            print("Erro: ID do feirante é nulo.")
            completion(false)
            return
        }
        
        // Referência ao documento do feirante
        let feiranteRef = db.collection("feirantes").document(feiranteId)
        
        // Atualize os dados do feirante
        feiranteRef.updateData([
            "nome": feirante.nome,
            "email": feirante.email,
            "telefone": feirante.telefone,
            "nomeBanca": feirante.nomeBanca,
            "tiposDeProduto": feirante.tiposDeProduto,
            "descricao": feirante.descricao
        ]) { error in
            if let error = error {
                print("Erro ao atualizar o feirante: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Feirante atualizado com sucesso.")
                completion(true)
            }
        }
    }
    
    func prepararFeirante(){
        self.fetchProdutosDoFeirante(emailFeirante: self.feiranteAtual.email){ _ in //Atualizo meu vetor de produtos local com o email do feirante que eu achei
            
            //Atualizo também meus pedidos e meu vetor de clientes para o feirante atual, apenas os clientes que realizaram pedidos para esse feirante
            
            self.fetchPedidosDoFeirante(feiranteId: self.feiranteAtual.id ?? "teste" ){ success in
                if success{
                    // Inicializa o array para ter o mesmo tamanho de pedidosFeirante
                    self.clientesParaOsFeirantes = Array(repeating: Cliente(nome: "", email: "", telefone: "", senha: "", predio: "", apartamento: ""), count: self.pedidosFeirante.count)
                    for i in 0..<self.pedidosFeirante.count {
                        self.fetchClienteWithId(id: self.pedidosFeirante[i].clienteId){ cliente in
                            self.clientesParaOsFeirantes[i] = cliente ?? self.clienteAtual
                        }
                    }
                    self.pedidosFeiranteLoaded = true
                }
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
    
    func fetchCliente(email: String, completion: @escaping (Cliente?) -> Void) {
        db.collection("clientes").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Erro ao buscar cliente: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let document = querySnapshot?.documents.first else {
                print("Cliente não encontrado.")
                completion(nil)
                return
            }
            
            do {
                var cliente = try document.data(as: Cliente.self)
                cliente.id = document.documentID
                completion(cliente)
            } catch {
                print("Erro ao decodificar cliente: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func editarCliente(cliente: Cliente, completion: @escaping (Bool) -> Void) {
        // Verifique se o ID do feirante está presente
        guard let clienteId = cliente.id else {
            print("Erro: ID do cliente é nulo.")
            completion(false)
            return
        }
        
        // Referência ao documento do feirante
        let clienteRef = db.collection("clientes").document(clienteId)
        
        // Atualize os dados do feirante
        clienteRef.updateData([
            "nome": cliente.nome,
            "email": cliente.email,
            "telefone": cliente.telefone,
            "predio": cliente.predio,
            "apartamento": cliente.apartamento,
        ]) { error in
            if let error = error {
                print("Erro ao atualizar o cliente: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Cliente atualizado com sucesso.")
                completion(true)
            }
        }
    }
    
    func fetchClienteWithId(id: String, completion: @escaping (Cliente?) -> Void) {
        db.collection("clientes").document(id).getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Erro ao buscar cliente: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists else {
                print("Cliente não encontrado.")
                completion(nil)
                return
            }

            do {
                var cliente = try documentSnapshot.data(as: Cliente.self)
                cliente.id = documentSnapshot.documentID // Atribui manualmente o ID do documento
                completion(cliente)
            } catch {
                print("Erro ao decodificar cliente: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

    func prepararCliente(){
        self.fetchFeirantes(){ success in
            if success{
                self.feirantesLoaded = true
            }
        }
        //Atualizo também meus pedidos e também meu vetor de feirantes para os clientes, mas apenas os feirantes que tem pedidos feito por esse cliente
        self.fetchPedidosDoCliente(clienteId: self.clienteAtual.id ?? "teste" ){ success in
            if success{
                self.feirantesParaOsCliente = Array(repeating: Feirante(nome: "", email: "", telefone: "", senha: "", nomeBanca: "", tiposDeProduto: "", descricao: ""), count: self.pedidosCliente.count)
                for i in 0..<self.pedidosCliente.count{
                    self.fetchFeiranteWithId(id: self.pedidosCliente[i].feiranteId){ feirante in
                        self.feirantesParaOsCliente[i] = feirante ?? self.feiranteAtual
                    }
                }
                self.pedidosClienteLoaded = true
            }
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
    
    func editarProduto(produto: Produto, completion: @escaping (Bool) -> ()) {
        
        
        guard let produtoId = produto.id else {
            print("Erro: ID do produto é nulo.")
            completion(false)
            return
        }
        
        // Referência ao documento do feirante
        let produtoRef = db.collection("produtos").document(produtoId)
        
        // Atualize os dados do feirante
        produtoRef.updateData([
            "nome": produto.nome,
            "preco": produto.preco,
            "quantidade": produto.quantidade,
            "descricao": produto.descricao,
            "feiranteEmail": produto.feiranteEmail
        ]) { error in
            if let error = error {
                print("Erro ao atualizar o produto: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Produto atualizado com sucesso.")
                completion(true)
            }
        }
    }
    
    
    //Funções Pedidos ------------------------------------------------------------------
    
    
    
    func addPedido(pedido: Pedido, completion: @escaping (Bool) -> Void) {
        // Criando uma representação do pedido que será armazenada no Firestore
        let dadosPedido = [
            "produtoId": pedido.produtoId,
            "produtoNome": pedido.produtoNome,
            "clienteId": pedido.clienteId,
            "feiranteId": pedido.feiranteId,
            "quantidade": pedido.quantidade,
            "observacao": pedido.observacao,
            "estado": pedido.estado
        ] as [String : Any]
        
        // Adicionando o pedido ao Firestore
        db.collection("pedidos").addDocument(data: dadosPedido) { error in
            if let error = error {
                print("Erro ao adicionar pedido: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Pedido adicionado com sucesso.")
                completion(true)
            }
        }
    }
    
    func fetchPedidosDoCliente(clienteId: String, completion: @escaping (Bool) -> Void) {
        db.collection("pedidos").whereField("clienteId", isEqualTo: clienteId).getDocuments() { [weak self] (querySnapshot, err) in
            if let err = err {
                print("Erro ao obter pedidos: \(err)")
                completion(false)
            } else {
                var pedidosTemp: [Pedido] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let pedido = Pedido(
                        id: document.documentID,
                        produtoId: data["produtoId"] as? String ?? "",
                        produtoNome: data["produtoNome"] as? String ?? "",
                        clienteId: data["clienteId"] as? String ?? "",
                        feiranteId: data["feiranteId"] as? String ?? "",
                        quantidade: data["quantidade"] as? Int ?? 0,
                        observacao: data["observacao"] as? String ?? "",
                        estado: data["estado"] as? Int ?? 0
                    )
                    pedidosTemp.append(pedido)
                }
                DispatchQueue.main.async {
                    self?.pedidosCliente = pedidosTemp
                    completion(true)
                }
            }
        }
    }
    
    func fetchPedidosDoFeirante(feiranteId: String, completion: @escaping (Bool) -> Void) {
        db.collection("pedidos").whereField("feiranteId", isEqualTo: feiranteId).getDocuments() { [weak self] (querySnapshot, err) in
            if let err = err {
                print("Erro ao obter pedidos: \(err)")
                completion(false)
            } else {
                var pedidosTemp: [Pedido] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let pedido = Pedido(
                        id: document.documentID,
                        produtoId: data["produtoId"] as? String ?? "",
                        produtoNome: data["produtoNome"] as? String ?? "",
                        clienteId: data["clienteId"] as? String ?? "",
                        feiranteId: data["feiranteId"] as? String ?? "",
                        quantidade: data["quantidade"] as? Int ?? 0,
                        observacao: data["observacao"] as? String ?? "",
                        estado: data["estado"] as? Int ?? 0
                    )
                    pedidosTemp.append(pedido)
                }
                DispatchQueue.main.async {
                    self?.pedidosFeirante = pedidosTemp
                    completion(true)
                }
            }
        }
    }
    
    func editarPedido(pedido: Pedido, completion: @escaping (Bool) -> ()) {
        
        guard let pedidoId = pedido.id else {
            print("Erro: ID do pedido é nulo.")
            completion(false)
            return
        }
        
        // Referência ao documento do feirante
        let pedidoRef = db.collection("pedidos").document(pedidoId)
        
        // Atualize os dados do feirante
        pedidoRef.updateData([
            "produtoNome": pedido.produtoNome,
            "quantidade": pedido.quantidade,
            "observacao": pedido.observacao,
            "estado": pedido.estado,
        ]) { error in
            if let error = error {
                print("Erro ao atualizar o pedido: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Pedido atualizado com sucesso.")
                completion(true)
            }
        }
    }
    
    
    
}




