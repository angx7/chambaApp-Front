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
        PrestadorService.shared.obtenerPorSubservicio(nombre: titulo) { resultado, error in
            if let resultado = resultado {
                DispatchQueue.main.async {
                    self.prestadores = resultado
                }
            } else {
                print("Error cargando prestadores:", error?.localizedDescription ?? "Desconocido")
            }
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
