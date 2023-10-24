//
//  Reserva.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 23/10/23.
//

import Foundation
import FirebaseCore

struct Reserva: Codable, Identifiable{
    var id: String?
    var produto: Produto
    var cliente: Cliente
    var quantidade: Int
    var estado: String
    
    func toAnyObject() -> Any {
        return [
            "id": id ?? UUID(),
            "produto": produto,
            "cliente": cliente,
            "quantidade": quantidade,
            "estado": estado,
        ]
    }
}
