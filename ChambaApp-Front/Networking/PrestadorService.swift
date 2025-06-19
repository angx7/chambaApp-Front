//
//  PrestadorService.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 17/06/25.
//

import Foundation

class PrestadorService {
    static let shared = PrestadorService()
    
    func obtenerPorSubservicio(nombre: String, completion: @escaping ([Prestador]?, Error?) -> Void) {
        guard let encoded = nombre.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(Constants.baseURL)/prestadores/subservicio/\(encoded)") else {
            completion(nil, NSError(domain: "URL inválida", code: 0))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: 0))
                return
            }
            
            do {
                let prestadores = try JSONDecoder().decode([Prestador].self, from: data)
                completion(prestadores, nil)
            } catch {
                print("❌ Error decode:", error)
                print("📦 Raw data:", String(data: data, encoding: .utf8) ?? "???")
                completion(nil, error)
            }
        }.resume()
    }
}
