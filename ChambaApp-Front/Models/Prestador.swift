//
//  Prestador.swift
//  ChambaApp-Front
//
//  Created by Ximena Gutierrez on 11/06/25.
//

import Foundation

//struct Prestador: Identifiable, Codable {
//    let id: UUID
//    let nombre: String
//    let edad: Int
//    let descripcion: String
//    let imagenURL: URL
//}

import Foundation

struct Prestador: Identifiable, Codable {
    let id: String
    let nombre: String
    let edad: Int
    let telefono: String
    let subservicio: String
    let imagenURL: String
    let descripcion: String
    let experiencia: String
    let ubicacion: String
    let calificacion: Double
    let reseñas: [Reseña]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nombre, edad, telefono, subservicio
        case imagenURL = "fotoURL"
        case descripcion, experiencia, ubicacion, calificacion, reseñas
    }
    
    enum ObjectIdKeys: String, CodingKey {
        case oid = "$oid"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let objectIdContainer = try container.nestedContainer(keyedBy: ObjectIdKeys.self, forKey: .id)
        self.id = try objectIdContainer.decode(String.self, forKey: .oid)
        
        self.nombre = try container.decode(String.self, forKey: .nombre)
        self.edad = try container.decode(Int.self, forKey: .edad)
        self.telefono = try container.decode(String.self, forKey: .telefono)
        self.subservicio = try container.decode(String.self, forKey: .subservicio)
        self.imagenURL = try container.decode(String.self, forKey: .imagenURL)
        self.descripcion = try container.decode(String.self, forKey: .descripcion)
        self.experiencia = try container.decode(String.self, forKey: .experiencia)
        self.ubicacion = try container.decode(String.self, forKey: .ubicacion)
        self.calificacion = try container.decode(Double.self, forKey: .calificacion)
        self.reseñas = try container.decode([Reseña].self, forKey: .reseñas)
    }
}

struct Reseña: Codable, Identifiable {
    let id = UUID() // Genera un ID único
    let cliente: String
    let comentario: String
    let calificacion: Int
    let fecha: String
}
