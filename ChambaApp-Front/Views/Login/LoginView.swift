//
//  LoginView.swift
//  ChambaApp-Front
//
//  Created by Grecia Navarrete on 10/06/25.
//

import SwiftUI

struct LoginView: View {
    var onLoginSuccess: () -> Void
    var onRegisterTap: () -> Void
    
    @State private var username = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var isLoading = false
    
    @State private var usernameEmpty = false
    @State private var passwordEmpty = false
    @State private var usernameInvalid = false
    @State private var passwordInvalid = false
    @State private var errorMessage = ""
    @State private var navegarARecuperar = false
    
    // Persistencia con AppStorage
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("loggedUsername") private var loggedUsername: String = ""
    
    func login() {
        usernameEmpty = username.trimmingCharacters(in: .whitespaces).isEmpty
        passwordEmpty = password.trimmingCharacters(in: .whitespaces).isEmpty
        usernameInvalid = false
        passwordInvalid = false
        errorMessage = ""
        
        guard !usernameEmpty, !passwordEmpty else {
            errorMessage = "Por favor completa todos los campos"
            return
        }
        
        isLoading = true
        
        AuthService.shared.login(username: username, password: password) { success, reason in
            DispatchQueue.main.async {
                isLoading = false
                
                if success {
                    // GUARDAR EN STORAGE
                    isLoggedIn = true
                    loggedUsername = username
                    onLoginSuccess()
                } else {
                    if reason == "Usuario no encontrado" {
                        usernameInvalid = true
                    } else if reason == "Contraseña incorrecta" {
                        passwordInvalid = true
                    }
                    errorMessage = reason ?? "Error desconocido"
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("FondoPrincipal").ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color("TextoPrincipal"))
                        .padding(.top, 50)
                    
                    // Username Field
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(Color("TextoPrincipal"))
                        
                        TextField("username", text: $username)
                            .foregroundColor(Color("TextoPrincipal"))
                            .autocapitalization(.none)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color("FondoTarjeta")))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder((usernameEmpty || usernameInvalid) ? Color.red : Color.clear, lineWidth: 1.5)
                    )
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                    .padding(.horizontal, 30)
                    
                    // Password Field
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(Color("TextoPrincipal"))
                        
                        if showPassword {
                            TextField("password", text: $password)
                                .foregroundColor(Color("TextoPrincipal"))
                                .id("TextPassword")
                        } else {
                            SecureField("password", text: $password)
                                .foregroundColor(Color("TextoPrincipal"))
                                .id("SecurePassword")
                        }
                        
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color("FondoTarjeta")))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder((passwordEmpty || passwordInvalid) ? Color.red : Color.clear, lineWidth: 1.5)
                    )
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                    .padding(.horizontal, 30)
                    
                    // Error message
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, -10)
                    }
                    
                    NavigationLink(destination: ActualizarContrasenaView(), isActive: $navegarARecuperar) {
                        Button(action: {
                            navegarARecuperar = true
                        }) {
                            Text("¿Olvidaste tu contraseña?")
                                .font(.footnote)
                                .foregroundColor(Color("TextoPrincipal"))
                                .underline()
                        }
                    }
                    
                    Button {
                        login()
                    } label: {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color("TextoPrincipal")))
                                .frame(maxWidth: 200)
                                .padding()
                        } else {
                            Text("LOGIN")
                                .font(.headline)
                                .foregroundColor(Color("TextoPrincipal"))
                                .frame(maxWidth: 200)
                                .padding()
                                .background(Color("BotonPrimario"))
                                .cornerRadius(8)
                        }
                    }
                    
                    Button("¿No tienes cuenta? Regístrate") {
                        onRegisterTap()
                    }
                    .font(.footnote)
                    .foregroundColor(Color("TextoPrincipal"))
                    .underline()
                    .padding(.top, 10)
                    
                    Spacer()
                }
            }
        }
    }
}
