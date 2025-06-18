//
//  ReseñaView.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 18/06/25.
//

import SwiftUI

struct ReseñaView: View {
    let reseña: Reseña

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(reseña.cliente)
                    .font(.headline)
                    .foregroundColor(Color("TextoPrincipal"))
                Spacer()
                Text(reseña.fecha)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            HStack(spacing: 4) {
                ForEach(0..<5) { i in
                    Image(systemName: i < reseña.calificacion ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.caption)
                }
            }

            Text(reseña.comentario)
                .font(.body)
                .foregroundColor(Color("TextoPrincipal"))
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(10)
    }
}
