//
//  PrestadorRowView.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 18/06/25.
//

import SwiftUI

struct PrestadorRowView: View {
    let prestador: Prestador
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Imagen del prestador
            AsyncImage(url: URL(string: prestador.imagenURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(12)
                case .failure:
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            // Info del prestador
            VStack(alignment: .leading, spacing: 6) {
                Text(prestador.nombre)
                    .font(.headline)
                    .foregroundColor(Color("TextoPrincipal"))
                
                Text("\(prestador.edad) años")
                    .font(.subheadline)
                    .foregroundColor(Color("TextoPrincipal"))
                
                Text(prestador.descripcion)
                    .font(.subheadline)
                    .foregroundColor(Color("TextoPrincipal"))
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(Color.white.opacity(0.2))
        .cornerRadius(16)
        .shadow(radius: 3)
        .padding(.horizontal, 20)
    }
}

