//
//  Usuario.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 17/06/25.
//
struct Usuario: Identifiable, Codable {
    let id: String
    var usuario: String
    var nombreCompleto: String
    var fechaNacimiento: String
    var domicilio: String
    var cp: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case usuario
        case nombreCompleto
        case fechaNacimiento
        case domicilio
        case cp
    }
    
    enum ObjectIdKeys: String, CodingKey {
        case oid = "$oid"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idContainer = try container.nestedContainer(keyedBy: ObjectIdKeys.self, forKey: .id)
        id = try idContainer.decode(String.self, forKey: .oid)
        
        usuario = try container.decode(String.self, forKey: .usuario)
        nombreCompleto = try container.decode(String.self, forKey: .nombreCompleto)
        fechaNacimiento = try container.decode(String.self, forKey: .fechaNacimiento)
        domicilio = try container.decode(String.self, forKey: .domicilio)
        cp = try container.decode(String.self, forKey: .cp)
    }
}
