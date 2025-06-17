//
//  PrestadoresListView.swift
//  ChambaApp-Front
//
//  Created by Grecia Navarrete on 11/06/25.
//

import SwiftUI

struct PrestadoresListView: View {
    let titulo: String
    @State private var prestadores: [Prestador] = []

    var body: some View {
        ZStack {
            // Fondo adaptable
            Color("FondoPrincipal")
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    Text(titulo.uppercased())
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color("TextoPrincipal"))
                        .padding(.top, 60)
                        .frame(maxWidth: .infinity, alignment: .center)

                    ForEach(prestadores) { p in
                        NavigationLink(destination: DetallePrestadorView(prestador: p)) {
                            PrestadorRowView(prestador: p)
                        }
                    }


                    Spacer(minLength: 50)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .onAppear {
            cargarPrestadores()
        }
    }

    func cargarPrestadores() {
        switch titulo {
        case "Cuidado de niños":
            prestadores = [
                Prestador(
                    id: UUID(),
                    nombre: "Laura González",
                    edad: 27,
                    telefono: "555-123-4567",
                    subservicio: "Cuidado de niños",
                    imagenURL: "https://cdn-icons-png.flaticon.com/512/236/236832.png",
                    descripcion: "Especialista en cuidado infantil",
                    experiencia: "5 años",
                    ubicacion: "CDMX",
                    calificacion: 4.8,
                    reseñas: [
                        Reseña(
                            cliente: "Marta López",
                            comentario: "Muy responsable y amable.",
                            calificacion: 5,
                            fecha: "2025-06-01"
                        )
                    ]
                ),
                Prestador(
                    id: UUID(),
                    nombre: "Alejandra Ramírez",
                    edad: 33,
                    telefono: "555-222-3344",
                    subservicio: "Cuidado de niños",
                    imagenURL: "https://cdn-icons-png.flaticon.com/512/6997/6997662.png",
                    descripcion: "Apoyo con tareas y juegos",
                    experiencia: "3 años",
                    ubicacion: "Monterrey",
                    calificacion: 4.6,
                    reseñas: []
                ),
                Prestador(
                    id: UUID(),
                    nombre: "María Téllez",
                    edad: 38,
                    telefono: "555-777-8888",
                    subservicio: "Cuidado de niños",
                    imagenURL: "https://cdn-icons-png.flaticon.com/512/6997/6997689.png",
                    descripcion: "Experiencia con niños pequeños",
                    experiencia: "6 años",
                    ubicacion: "Guadalajara",
                    calificacion: 4.9,
                    reseñas: [
                        Reseña(
                            cliente: "Sandra Reyes",
                            comentario: "Trato excelente con mis hijos.",
                            calificacion: 5,
                            fecha: "2025-05-20"
                        )
                    ]
                )
            ]

        case "Jardinería":
            prestadores = [
                Prestador(
                    id: UUID(),
                    nombre: "Carlos Rivera",
                    edad: 45,
                    telefono: "555-333-2222",
                    subservicio: "Jardinería",
                    imagenURL: "https://cdn-icons-png.flaticon.com/512/2922/2922802.png",
                    descripcion: "Diseño y mantenimiento de jardines",
                    experiencia: "10 años",
                    ubicacion: "Querétaro",
                    calificacion: 4.7,
                    reseñas: [
                        Reseña(
                            cliente: "Luis Martínez",
                            comentario: "Dejó mi jardín impecable.",
                            calificacion: 5,
                            fecha: "2025-06-05"
                        )
                    ]
                )
            ]

        case "Limpieza":
            prestadores = [
                Prestador(
                    id: UUID(),
                    nombre: "Ana López",
                    edad: 29,
                    telefono: "555-111-0000",
                    subservicio: "Limpieza",
                    imagenURL: "https://cdn-icons-png.flaticon.com/512/2922/2922510.png",
                    descripcion: "Limpieza profunda y rápida",
                    experiencia: "4 años",
                    ubicacion: "CDMX",
                    calificacion: 4.85,
                    reseñas: [
                        Reseña(
                            cliente: "Carmen Duarte",
                            comentario: "Muy detallista y puntual.",
                            calificacion: 5,
                            fecha: "2025-06-10"
                        )
                    ]
                )
            ]

        default:
            prestadores = []
        }
    }

}

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
