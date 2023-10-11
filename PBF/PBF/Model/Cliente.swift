//
//  Cliente.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 11/10/23.
//

import Foundation
import FirebaseCore

struct Cliente: Codable, Identifiable{
    var id: String?
    var nome: String
    var email: String
    var telefone: String
    var senha: String
    var predio: String
    var apartamento: String
    
    func toAnyObject() -> Any {
        return [
            "id": id,
            "nome": nome,
            "email": email,
            "telefone": telefone,
            "senha": senha,
            "predio": predio,
            "apartamento": apartamento
        ]
    }
}


