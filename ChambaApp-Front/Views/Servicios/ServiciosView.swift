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
    @AppStorage("loggedUserId") private var loggedUserId: String = ""
    @State private var showLogoutAlert = false
    @State private var navegarAConfiguracion = false

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

            Menu {
                Button("Configuración") {
                    navegarAConfiguracion = true
                }

                Button("Cerrar sesión", role: .destructive) {
                    showLogoutAlert = true
                }
            } label: {
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                    .padding(.top, 16)
                    .padding(.trailing, 20)
                    .foregroundColor(Color("TextoPrincipal"))
            }

            .alert("¿Seguro que deseas cerrar sesión?", isPresented: $showLogoutAlert) {
                Button("Cancelar", role: .cancel) { }

                Button("Cerrar sesión", role: .destructive) {
                    isLoggedIn = false
                    loggedUserId = ""
                    onLogout()
                }
            }

            // NavigationLink invisible para ir a ConfiguracionView
            NavigationLink(destination: ConfiguracionView(onLogout: {
                isLoggedIn = false
                loggedUserId = ""
                onLogout()
            }), isActive: $navegarAConfiguracion) {
                EmptyView()
            }

        }
    }
}

