//
//  Feirante.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 23/10/23.
//

import Foundation
import FirebaseCore

struct Feirante: Codable, Identifiable{
    var id: String?
    var nome: String
    var email: String
    var telefone: String
    var senha: String
    var nomeBanca: String
    var tiposDeProduto: String
    var descricao: String
    
    func toAnyObject() -> Any {
        return [
            "id": id,
            "nome": nome,
            "email": email,
            "telefone": telefone,
            "senha": senha,
            "nomeBanca": nomeBanca,
            "tiposDeProduto": tiposDeProduto,
            "descricao": descricao
        ]
    }
}
