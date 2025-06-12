//
//  Prestador.swift
//  ChambaApp-Front
//
//  Created by Ximena Gutierrez on 11/06/25.
//

import Foundation

struct Prestador: Identifiable, Codable {
    let id: UUID
    let nombre: String
    let edad: Int
    let descripcion: String
    let imagenURL: URL
}
