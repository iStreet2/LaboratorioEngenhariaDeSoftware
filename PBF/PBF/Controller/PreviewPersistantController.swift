//
//  PreviewPersistantController.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 23/10/23.
//

import Foundation
import CoreData

struct PreviewPersistenceController {
    static let shared = PreviewPersistenceController()

    static var preview: NSPersistentContainer = {
        let controller = NSPersistentContainer(name: "Model")
        controller.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError("Erro no CoreData: \(error)")
            }
        })
        return controller
    }()
}

