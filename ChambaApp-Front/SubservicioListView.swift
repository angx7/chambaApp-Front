//
//  SubservicioListView.swift
//  ChambaApp-Front
//
//  Created by Grecia Navarrete on 10/06/25.
//





import SwiftUI

struct SubservicioListView: View {
    let titulo: String
    @State private var subservicios: [Subservicio] = []

    var body: some View {
        ZStack {
            // Fondo azul claro en toda la pantalla
            Color(red: 206/255, green: 237/255, blue: 241/255)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {
                    Text(titulo.uppercased())
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 40)

                    ForEach(subservicios) { item in
                        VStack(spacing: 8) {
                            Text(item.nombre)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .background(Color(red: 26/255, green: 62/255, blue: 66/255))
                                .cornerRadius(12)

                            AsyncImage(url: item.imagenURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 200, height: 150)
                                        .cornerRadius(8)
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
            }
        }
        .onAppear {
            cargarSubservicios()
        }
    }

    func cargarSubservicios() {
        switch titulo {
        case "Doméstico":
            subservicios = [
                Subservicio(
                    id: UUID(),
                    nombre: "Cuidado de niños",
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2017/01/06/19/15/kids-1959827_960_720.jpg")!
                )
            ]
        case "Empresarial":
            subservicios = [
                Subservicio(
                    id: UUID(),
                    nombre: "Limpieza de oficinas",
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2018/04/18/18/56/cleaning-3334801_960_720.jpg")!
                )
            ]
        case "Otros":
            subservicios = [
                Subservicio(
                    id: UUID(),
                    nombre: "Soporte técnico",
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2016/10/31/18/14/tools-1783901_960_720.jpg")!
                )
            ]
        default:
            subservicios = []
        }
    }
}
