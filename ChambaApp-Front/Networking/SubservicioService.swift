//
//  SubservicioService.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 17/06/25.
//

import Foundation

class SubservicioService {
    static let shared = SubservicioService()
    
    func obtenerSubservicios(categoria: String, completion: @escaping ([Subservicio]?, Error?) -> Void) {
        guard let encodedCategoria = categoria.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(Constants.baseURL)/subservicios?categoria=\(encodedCategoria)") else {
            completion(nil, NSError(domain: "URL inválida", code: 0))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "Sin datos", code: 0))
                return
            }
            
            do {
                let subservicios = try JSONDecoder().decode([Subservicio].self, from: data)
                completion(subservicios, nil)
            } catch {
                print("Error decoding:", error)
                print("Raw:", String(data: data, encoding: .utf8) ?? "")
                completion(nil, error)
            }
        }.resume()
    }
}
