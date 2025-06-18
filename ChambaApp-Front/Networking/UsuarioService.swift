//
//  UsuarioService.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 17/06/25.
//

import Foundation

class UsuarioService {
    static let shared = UsuarioService()

    func obtenerUsuarioPorID(_ id: String, completion: @escaping (Usuario?) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/usuarios/\(id)") else {
            print("URL inválida")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("❌ Error al obtener usuario:", error)
                completion(nil)
                return
            }

            guard let data = data else {
                print("❌ Sin datos")
                completion(nil)
                return
            }

            do {
                let usuario = try JSONDecoder().decode(Usuario.self, from: data)
                completion(usuario)
            } catch {
                print("❌ Error al decodificar usuario:", error)
                print(String(data: data, encoding: .utf8) ?? "Sin contenido")
                completion(nil)
            }
        }.resume()
    }
    
    func actualizarUsuario(_ usuario: Usuario, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/usuarios/\(usuario.id)") else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(usuario)
            request.httpBody = jsonData
        } catch {
            print("❌ Error codificando usuario:", error)
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("❌ Error en la petición:", error)
                completion(false)
                return
            }

            guard let httpResp = response as? HTTPURLResponse, httpResp.statusCode == 200 else {
                print("⚠️ Código inesperado:", (response as? HTTPURLResponse)?.statusCode ?? 0)
                completion(false)
                return
            }

            completion(true)
        }.resume()
    }
    
    
    func eliminarUsuario(id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/usuarios/\(id)") else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("❌ Error al eliminar usuario:", error)
                completion(false)
                return
            }

            guard let httpResp = response as? HTTPURLResponse, httpResp.statusCode == 200 else {
                print("⚠️ Código inesperado:", (response as? HTTPURLResponse)?.statusCode ?? 0)
                completion(false)
                return
            }

            completion(true)
        }.resume()
    }


}
