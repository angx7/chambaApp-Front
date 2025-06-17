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

struct Prestador: Identifiable {
    var id: UUID
    var nombre: String
    var edad: Int
    var telefono: String?
    var subservicio: String?
    var imagenURL: String
    var descripcion: String
    var experiencia: String?
    var ubicacion: String?
    var calificacion: Double?
    var reseñas: [Reseña]?
}

struct Reseña: Identifiable {
    var id = UUID()
    var cliente: String
    var comentario: String
    var calificacion: Int
    var fecha: String
}
