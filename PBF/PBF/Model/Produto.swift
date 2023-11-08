//
//  Produto.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 23/10/23.
//

import Foundation
import SwiftUI

struct Produto: Codable, Identifiable {
    var id: String?
    var nome: String
    var preco: String
    var quantidade: Int
    var descricao: String
    var feiranteEmail: String

    func toAnyObject() -> Any {
        return [
            "id": id ?? "",
            "nome": nome,
            "preço": preco,
            "quantidade": quantidade,
            "descricao": descricao,
            "feiranteEmail": feiranteEmail
        ]
    }
}
