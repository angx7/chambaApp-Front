//
//  ServiciosView.swift
//  ChambaApp-Front
//
//  Created by Grecia Navarrete on 10/06/25.
//
import SwiftUI

struct ServiciosView: View {
    var onLogout: () -> Void  // Callback para cerrar sesión

    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("loggedUsername") private var loggedUsername: String = ""

    @State private var showLogoutAlert = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color("FondoPrincipal").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 50) {
                    Text("SERVICIOS")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color("TextoPrincipal"))
                        .padding(.top, 60)

                    NavigationLink(destination: SubservicioListView(titulo: "Domestico")) {
                        ServicioItem(
                            icon: "house.fill",
                            title: "Doméstico",
                            description: """
                            Ofrece limpieza general del hogar, lavado y planchado, cocina básica y asistencia en tareas del hogar para mantener un ambiente limpio y ordenado.
                            """
                        )
                    }

                    NavigationLink(destination: SubservicioListView(titulo: "Empresarial")) {
                        ServicioItem(
                            icon: "person.3.fill",
                            title: "Empresarial",
                            description: """
                            Brinda limpieza profesional de oficinas, manejo de residuos, reposición de insumos, desinfección y mantenimiento básico para garantizar espacios laborales seguros y presentables.
                            """
                        )
                    }

                    NavigationLink(destination: SubservicioListView(titulo: "Otros")) {
                        ServicioItem(
                            icon: "gearshape.fill",
                            title: "Otros",
                            description: """
                            Complementan las soluciones principales, adaptándose a necesidades específicas del cliente y ofreciendo apoyo extra según el entorno o situación particular.
                            """
                        )
                    }

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, alignment: .center)
            }

            // Botón de logout con alerta
            Button("Logout") {
                showLogoutAlert = true
            }
            .font(.footnote)
            .padding(.top, 16)
            .padding(.trailing, 20)
            .foregroundColor(Color("TextoPrincipal"))
            .alert("¿Seguro que deseas cerrar sesión?", isPresented: $showLogoutAlert) {
                Button("Cancelar", role: .cancel) { }

                Button("Cerrar sesión", role: .destructive) {
                    isLoggedIn = false
                    loggedUsername = ""
                    onLogout()
                }
            }
        }
    }
}


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
