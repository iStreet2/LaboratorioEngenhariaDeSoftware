//
//  Reserva.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 23/10/23.
//

import Foundation
import FirebaseCore

struct Pedido: Codable, Identifiable, Hashable{
    var id: String?
    var produtoId: String
    var produtoNome: String
    var clienteId: String
    var feiranteId: String
    var quantidade: Int
    var observacao: String
    var estado: Int
    
    func toAnyObject() -> Any {
        return [
            "id": id ?? UUID(),
            "produtoId": produtoId,
            "produtoNome": produtoNome,
            "clienteId": clienteId,
            "feiranteId": feiranteId,
            "quantidade": quantidade,
            "observacao": observacao,
            "estado": estado
        ]
    }
}
