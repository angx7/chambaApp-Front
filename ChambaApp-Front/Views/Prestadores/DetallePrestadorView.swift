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

            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        // Imagen de perfil
                        AsyncImage(url: URL(string: prestador.imagenURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 120, height: 120)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            case .failure:
                                Image(systemName: "person.crop.circle.badge.exclamationmark")
                                    .resizable()
                                    .frame(width: 120, height: 120)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .padding(.top, 40)

                        // Nombre, edad y descripción
                        Text(prestador.nombre)
                            .font(.title)
                            .bold()
                            .foregroundColor(Color("TextoPrincipal"))

                        Text("\(prestador.edad) años")
                            .font(.subheadline)
                            .foregroundColor(Color("TextoPrincipal"))

                        Text(prestador.descripcion)
                            .font(.body)
                            .foregroundColor(Color("TextoPrincipal"))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        // Calificación general con estrellas
                        HStack(spacing: 4) {
                            ForEach(0..<5) { i in
                                Image(systemName: i < Int(round(prestador.calificacion ?? 0)) ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                            }
                            Text(String(format: "(%.2f)", prestador.calificacion ?? 0))
                                .font(.subheadline)
                                .foregroundColor(Color("TextoPrincipal"))
                        }

                        Divider().padding(.vertical, 10)

                        // Sobre mí
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Sobre mí")
                                .font(.headline)
                                .foregroundColor(Color("TextoPrincipal"))

                            Text("Hola, soy \(prestador.nombre). Tengo \(prestador.experiencia.lowercased() ?? "0 años") de experiencia en el área \"\(prestador.subservicio.lowercased() ?? "")\". Me encanta ayudar a las personas y brindar un servicio de calidad.")
                                .font(.body)
                                .foregroundColor(Color("TextoPrincipal"))
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.horizontal)

                        // Reseñas
                        if !(prestador.reseñas.isEmpty ?? false) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Reseñas")
                                    .font(.headline)
                                    .foregroundColor(Color("TextoPrincipal"))

                                ForEach(prestador.reseñas ?? []) { reseña in
                                    ReseñaView(reseña: reseña)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 30) // Espacio para que no se esconda tras el botón
                        }
                    }
                }

                // Botón fijo abajo
                Button(action: {
                    // Acción: abrir chat, llamar, etc.
                }) {
                    Text("Contactar a \(prestador.nombre.components(separatedBy: " ").first ?? "prestador")")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("BotonPrimario"))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
                .background(Color("FondoPrincipal").ignoresSafeArea(edges: .bottom))
            }
        }
    }

}

// MARK: - Subvista para cada reseña
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

// MARK: - Modelos (solo para esta vista temporal)



// MARK: - Preview para pruebas

//#Preview {
//    let ejemplo = Prestador(
//        id: UUID(),
//        nombre: "Diana Gómez",
//        edad: 26,
//        telefono: "555-555-6666",
//        subservicio: "Cuidado de mascotas",
//        imagenURL: "https://example.com/img/diana.jpg",
//        descripcion: "Paseadora profesional y cuidadora de animales.",
//        experiencia: "4 años",
//        ubicacion: "Querétaro",
//        calificacion: 4.95,
//        reseñas: [
//            Reseña(cliente: "Samantha Torres", comentario: "Mis perritos la aman.", calificacion: 5, fecha: "2025-06-09")
//        ]
//    )
//
//    DetallePrestadorView(prestador: ejemplo)
//}
