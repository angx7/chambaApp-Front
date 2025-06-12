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
                            HStack(alignment: .top, spacing: 16) {
                                // Imagen del prestador
                                AsyncImage(url: p.imagenURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    case .failure:
                                        Image(systemName: "person.crop.rectangle")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }

                                VStack(alignment: .leading, spacing: 8) {
                                    Text(p.nombre)
                                        .font(.headline)
                                        .foregroundColor(Color("TextoPrincipal"))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 4)
                                        .background(Color("FondoTarjeta"))
                                        .cornerRadius(8)

                                    Text("\(p.edad) años")
                                        .font(.subheadline)
                                        .foregroundColor(Color("TextoPrincipal"))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 4)
                                        .background(Color("FondoTarjeta"))
                                        .cornerRadius(8)

                                    Text(p.descripcion)
                                        .font(.body)
                                        .foregroundColor(Color("TextoPrincipal"))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color("FondoTarjeta"))
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.horizontal, 24)
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
                    descripcion: "Especialista en cuidado infantil",
                    imagenURL: URL(string: "https://cdn-icons-png.flaticon.com/512/236/236832.png")!
                ),
                Prestador(
                    id: UUID(),
                    nombre: "Alejandra Ramírez",
                    edad: 33,
                    descripcion: "Apoyo con tareas y juegos",
                    imagenURL: URL(string: "https://cdn-icons-png.flaticon.com/512/6997/6997662.png")!
                ),
                Prestador(
                    id: UUID(),
                    nombre: "María Téllez",
                    edad: 38,
                    descripcion: "Experiencia con niños pequeños",
                    imagenURL: URL(string: "https://cdn-icons-png.flaticon.com/512/6997/6997689.png")!
                )
            ]
        case "Jardinería":
            prestadores = [
                Prestador(
                    id: UUID(),
                    nombre: "Carlos Rivera",
                    edad: 45,
                    descripcion: "Diseño y mantenimiento de jardines",
                    imagenURL: URL(string: "https://cdn-icons-png.flaticon.com/512/2922/2922802.png")!
                )
            ]
        case "Limpieza":
            prestadores = [
                Prestador(
                    id: UUID(),
                    nombre: "Ana López",
                    edad: 29,
                    descripcion: "Limpieza profunda y rápida",
                    imagenURL: URL(string: "https://cdn-icons-png.flaticon.com/512/2922/2922510.png")!
                )
            ]
        default:
            prestadores = []
        }
    }
}
