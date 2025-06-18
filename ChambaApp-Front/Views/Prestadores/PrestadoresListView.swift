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
