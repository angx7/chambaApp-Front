//
//  ActualizarContrasenaView.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 18/06/25.
//

import SwiftUI

struct ActualizarContrasenaView: View {
    @State private var usuario = ""
    @State private var nuevaContrasena = ""
    @State private var confirmarContrasena = ""
    @State private var mostrarContrasena = false
    @State private var errorMessage = ""
    @State private var showSuccessAlert = false
    @State private var isLoading = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color("FondoPrincipal").ignoresSafeArea()
            
            VStack(spacing: 24) {
                Image(systemName: "key.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.yellow)
                    .padding(.top, 40)
                
                Text("Actualizar Contraseña")
                    .font(.largeTitle)
                    .foregroundColor(Color("TextoPrincipal"))
                
                TextField("Usuario", text: $usuario)
                    .autocapitalization(.none)
                    .modifier(FormFieldModifier(invalid: usuario.isEmpty))
                
                HStack {
                    if mostrarContrasena {
                        TextField("Nueva contraseña", text: $nuevaContrasena)
                    } else {
                        SecureField("Nueva contraseña", text: $nuevaContrasena)
                    }
                    Button {
                        mostrarContrasena.toggle()
                    } label: {
                        Image(systemName: mostrarContrasena ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .modifier(FormFieldModifier(invalid: nuevaContrasena.isEmpty))
                
                SecureField("Confirmar nueva contraseña", text: $confirmarContrasena)
                    .modifier(FormFieldModifier(invalid: confirmarContrasena != nuevaContrasena))
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button {
                    actualizarContrasena()
                } label: {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Actualizar")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("BotonPrimario"))
                            .cornerRadius(8)
                    }
                }
                .disabled(isLoading)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .alert("Contraseña actualizada", isPresented: $showSuccessAlert) {
            Button("OK") {
                dismiss()
            }
        }
    }
    
    func actualizarContrasena() {
        errorMessage = ""
        
        guard !usuario.isEmpty, !nuevaContrasena.isEmpty, !confirmarContrasena.isEmpty else {
            errorMessage = "Todos los campos son obligatorios."
            return
        }
        
        guard nuevaContrasena == confirmarContrasena else {
            errorMessage = "Las contraseñas no coinciden."
            return
        }
        
        isLoading = true
        
        UsuarioService.shared.actualizarContrasena(usuario: usuario, nuevaContrasena: nuevaContrasena) { success, message in
            DispatchQueue.main.async {
                isLoading = false
                
                if success {
                    showSuccessAlert = true
                    usuario = ""
                    nuevaContrasena = ""
                    confirmarContrasena = ""
                } else {
                    errorMessage = message ?? "Error desconocido."
                }
            }
        }
    }
}
