//
//  SubservicioRowView.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 17/06/25.
//


import SwiftUI

struct SubservicioRowView: View {
    let subservicio: Subservicio
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            AsyncImage(url: URL(string: subservicio.imagenURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView().frame(width: 100, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(12)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(subservicio.nombre)
                    .font(.headline)
                    .foregroundColor(Color("TextoPrincipal"))
                
                Text(subservicio.descripcion)
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
