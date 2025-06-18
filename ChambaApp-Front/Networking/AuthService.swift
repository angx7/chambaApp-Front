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

            // Caso éxito: backend responde con {"status": "ok"}
            if let json = try? JSONDecoder().decode([String: String].self, from: data),
               json["status"] == "ok" {
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
}
