//
//  ConfiguracionView.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 17/06/25.
//

import SwiftUI

struct ConfiguracionView: View {
    @AppStorage("loggedUserId") private var loggedUserId: String = ""
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    @State private var usuario: Usuario?

    @State private var usuarioNombre: String = ""
    @State private var nombreCompleto: String = ""
    @State private var fechaNacimiento: String = ""
    @State private var domicilio: String = ""
    @State private var cp: String = ""

    @State private var showUpdateAlert = false
    @State private var showDeleteAlert = false
    @State private var cuentaEliminada = false

    var onLogout: () -> Void

    var body: some View {
        ZStack {
            Color("FondoPrincipal").ignoresSafeArea()

            VStack(spacing: 30) {
                Text("CONFIGURACIÓN")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("TextoPrincipal"))
                    .padding(.top, 60)

                if usuario != nil {
                    VStack(alignment: .leading, spacing: 12) {
                        ConfigRowEditable(label: "Usuario", value: $usuarioNombre)
                        ConfigRowEditable(label: "Nombre completo", value: $nombreCompleto)
                        ConfigRowEditable(label: "Fecha de nacimiento", value: $fechaNacimiento)
                        ConfigRowEditable(label: "Domicilio", value: $domicilio)
                        ConfigRowEditable(label: "Código Postal", value: $cp)
                    }
                    .padding(.horizontal, 24)
                } else {
                    ProgressView("Cargando usuario...")
                        .padding()
                }

                Spacer()

                VStack(spacing: 16) {
                    Button(action: {
                        showUpdateAlert = true
                    }) {
                        Text("Actualizar datos")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(role: .destructive, action: {
                        showDeleteAlert = true
                    }) {
                        Text("Eliminar cuenta")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }

        // Confirmación de actualización
        .alert("¿Deseas actualizar tus datos?", isPresented: $showUpdateAlert) {
            Button("Cancelar", role: .cancel) {}
            Button("Confirmar") {
                guard var user = usuario else { return }
                user.usuario = usuarioNombre
                user.nombreCompleto = nombreCompleto
                user.fechaNacimiento = fechaNacimiento
                user.domicilio = domicilio
                user.cp = cp

                UsuarioService.shared.actualizarUsuario(user) { success in
                    if success {
                        print("✅ Usuario actualizado correctamente")
                        self.usuario = user
                    } else {
                        print("❌ Error al actualizar")
                    }
                }
            }
        }

        // Confirmación de eliminación
        .alert("¿Seguro que deseas eliminar tu cuenta?", isPresented: $showDeleteAlert) {
            Button("Cancelar", role: .cancel) {}
            Button("Eliminar", role: .destructive) {
                UsuarioService.shared.eliminarUsuario(id: loggedUserId) { success in
                    DispatchQueue.main.async {
                        if success {
                            cuentaEliminada = true
                        } else {
                            print("❌ Falló la eliminación")
                        }
                    }
                }
            }
        }

        // Mensaje final tras eliminación
        .alert("Cuenta eliminada, esperamos verte pronto.", isPresented: $cuentaEliminada) {
            Button("Aceptar") {
                isLoggedIn = false
                loggedUserId = ""
                onLogout()
            }
        }

        .onAppear {
            UsuarioService.shared.obtenerUsuarioPorID(loggedUserId) { user in
                if let user = user {
                    DispatchQueue.main.async {
                        self.usuario = user
                        self.usuarioNombre = user.usuario
                        self.nombreCompleto = user.nombreCompleto
                        self.fechaNacimiento = user.fechaNacimiento
                        self.domicilio = user.domicilio
                        self.cp = user.cp
                    }
                }
            }
        }
    }
}

struct ConfigRowEditable: View {
    var label: String
    @Binding var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)

            TextField(label, text: $value)
                .font(.body)
                .foregroundColor(Color("TextoPrincipal"))
                .padding(8)
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)
        }
    }
}
