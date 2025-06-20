//
//  AuthService.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 12/06/25.
//

import Foundation

// Estructura para respuestas de error
struct LoginErrorResponse: Decodable {
    let error: Bool
    let reason: String
}

struct LoginSuccessResponse: Decodable {
    let status: String
    let id: String
}

class AuthService {
    static let shared = AuthService()
    
    func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/login") else {
            completion(false, "URL inválida")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["usuario": username, "contrasena": password]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, "Error de red: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion(false, "No se recibió respuesta")
                return
            }
            
            // Caso éxito: backend responde con {"id": "...", "status": "ok"}
            if let json = try? JSONDecoder().decode(LoginSuccessResponse.self, from: data),
               json.status == "ok" {
                UserDefaults.standard.set(json.id, forKey: "loggedUserId")
                completion(true, nil)
                
                // Caso error: backend responde con {"error": true, "reason": "..."}
            } else if let json = try? JSONDecoder().decode(LoginErrorResponse.self, from: data) {
                completion(false, json.reason)
                
                // Caso desconocido
            } else {
                let raw = String(data: data, encoding: .utf8) ?? "Respuesta no válida"
                completion(false, "Error desconocido: \(raw)")
            }
        }.resume()
    }
    
    // Nueva estructura de respuesta del registro
    struct RegistroResponse: Decodable {
        let status: String
        let id: String
    }
    
    func register(usuario: [String: String], completion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/usuarios") else {
            completion(false, "URL inválida")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(usuario)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, "Error de red: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion(false, "No se recibió respuesta")
                return
            }
            
            // ✅ Decodificamos la respuesta esperada del backend
            if let json = try? JSONDecoder().decode(RegistroResponse.self, from: data),
               json.status == "ok" {
                // Guardamos el ID en AppStorage o UserDefaults
                UserDefaults.standard.set(json.id, forKey: "loggedUserId")
                completion(true, nil)
                
            } else if let errorJson = try? JSONDecoder().decode([String: String].self, from: data),
                      let msg = errorJson["reason"] {
                completion(false, msg)
                
            } else {
                let raw = String(data: data, encoding: .utf8) ?? "Respuesta no válida"
                completion(false, "Error desconocido: \(raw)")
            }
        }.resume()
    }
    
    
    
}
