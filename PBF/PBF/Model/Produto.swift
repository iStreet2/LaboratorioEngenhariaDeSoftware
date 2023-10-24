//
//  Produto.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 23/10/23.
//

import Foundation
import FirebaseCore

struct Produto: Codable, Identifiable{
    var id: String?
    var nome: String
    var preco: Float
    var quantidade: Int
    
    func toAnyObject() -> Any {
        return [
            "id": id ?? UUID(),
            "nome": nome,
            "preço": preco,
            "quantidade": quantidade
        ]
    }
}
