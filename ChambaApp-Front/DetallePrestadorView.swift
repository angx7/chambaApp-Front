//
//  DetallePrestadorView.swift
//  ChambaApp-Front
//
//  Created by Grecia Navarrete on 11/06/25.
//

import SwiftUI

struct DetallePrestadorView: View {
    let prestador: Prestador

    var body: some View {
        ZStack {
            Color("FondoPrincipal").ignoresSafeArea()

            VStack(spacing: 30) {
                AsyncImage(url: prestador.imagenURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                            .resizable()
                            .frame(width: 120, height: 120)
                    @unknown default:
                        EmptyView()
                    }
                }

                Text("Reseñas")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("TextoPrincipal"))

                Text("Lorem ipsum dolor sit amet consectetur. Hac maecenas tellus aliquet sit odio eu sagittis imperdiet cum. Varius nec amet pellentesque purus malesuada sagittis eget amet senectus.")
                    .font(.body)
                    .foregroundColor(Color("TextoPrincipal"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("Calificación")
                    .font(.title3)
                    .foregroundColor(Color("TextoPrincipal"))
                    .padding(.top)

                Text("6/10")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("TextoPrincipal"))

                
                Button("Contacto") {
                    // Acción futura: enviar mensaje, abrir chat, etc.
                }
                .padding(20)
                .frame(maxWidth: 200)
                .background(Color("BotonPrimario"))
                .foregroundColor(.black)
                .cornerRadius(12)
            }
            .padding(.top, 40)
        }
    }
}

// MARK: - Ejemplo estático para previsualizar como si viniera del backend

#Preview {
    let ejemplo = Prestador(
        id: UUID(),
        nombre: "Laura González",
        edad: 27,
        descripcion: "Especialista en cuidado infantil",
        imagenURL: URL(string: "https://cdn-icons-png.flaticon.com/512/236/236832.png")!
    )

    return DetallePrestadorView(prestador: ejemplo)
}
