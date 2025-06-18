//
//  ServicioItem.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 18/06/25.
//
import SwiftUI

struct ServicioItem: View {
    var icon: String
    var title: String
    var description: String

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Ícono circular
            ZStack {
                Circle()
                    .stroke(Color("TextoPrincipal"), lineWidth: 2)
                    .frame(width: 70, height: 70)

                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .foregroundColor(Color("TextoPrincipal"))
            }

            // Texto alineado a la izquierda
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .bold()
                    .foregroundColor(Color("TextoPrincipal"))

                Text(description)
                    .font(.caption)
                    .foregroundColor(Color("TextoPrincipal"))
                    .multilineTextAlignment(.leading)
                    
                
            }
            Spacer()
        }
        .padding()
        .background(Color("FondoTarjeta"))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
    }
}
