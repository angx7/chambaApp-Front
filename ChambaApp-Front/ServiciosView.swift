//
//  ServiciosView.swift
//  ChambaApp-Front
//
//  Created by Grecia Navarrete on 10/06/25.
//





import SwiftUI

struct ServiciosView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                // Título con buena separación superior
                Text("SERVICIOS")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 60)

                // Secciones de servicios con navegación

                NavigationLink(destination: SubservicioListView(titulo: "Doméstico")) {
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
        .background(Color(red: 206/255, green: 237/255, blue: 241/255))
        .ignoresSafeArea()
    }
}

struct ServicioItem: View {
    var icon: String
    var title: String
    var description: String

    var body: some View {
        VStack(spacing: 16) {
            // Ícono
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.black)

            // Título
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.black)

            // Descripción
            Text(description)
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(red: 114/255, green: 153/255, blue: 156/255).opacity(0.3))
                .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
