//
//  Subservicio.swift
//  ChambaApp-Front
//
//  Created by Grecia Navarrete on 10/06/25.
//

import Foundation

struct Subservicio: Identifiable, Codable {
    let id: String
    let nombre: String
    let categoria: String
    let imagenURL: String
    let descripcion: String

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nombre
        case categoria
        case imagenURL
        case descripcion
    }

    private enum ObjectIdKeys: String, CodingKey {
        case oid = "$oid"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let objectIdContainer = try container.nestedContainer(keyedBy: ObjectIdKeys.self, forKey: .id)
        self.id = try objectIdContainer.decode(String.self, forKey: .oid)
        self.nombre = try container.decode(String.self, forKey: .nombre)
        self.categoria = try container.decode(String.self, forKey: .categoria)
        self.imagenURL = try container.decode(String.self, forKey: .imagenURL)
        self.descripcion = try container.decode(String.self, forKey: .descripcion)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var objectIdContainer = container.nestedContainer(keyedBy: ObjectIdKeys.self, forKey: .id)
        try objectIdContainer.encode(id, forKey: .oid)
        try container.encode(nombre, forKey: .nombre)
        try container.encode(categoria, forKey: .categoria)
        try container.encode(imagenURL, forKey: .imagenURL)
        try container.encode(descripcion, forKey: .descripcion)
    }
}
