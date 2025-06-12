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

    var body: some View {
        ZStack {
            Color("FondoPrincipal")
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("TextoPrincipal"))
                    .padding(.top, 50)

                HStack {
                    Image(systemName: "person")
                        .foregroundColor(Color("TextoPrincipal"))
                    TextField("username", text: $username)
                        .foregroundColor(Color("TextoPrincipal"))
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color("FondoTarjeta"))
                .cornerRadius(5)
                .padding(.horizontal, 30)

                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(Color("TextoPrincipal"))
                    SecureField("password", text: $password)
                        .foregroundColor(Color("TextoPrincipal"))
                }
                .padding()
                .background(Color("FondoTarjeta"))
                .cornerRadius(5)
                .padding(.horizontal, 30)

                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .foregroundColor(Color("TextoPrincipal"))

                Button("LOGIN") {
                    onLoginSuccess()
                }
                .font(.headline)
                .foregroundColor(Color("TextoPrincipal"))
                .padding()
                .frame(maxWidth: 200)
                .background(Color("BotonPrimario"))
                .cornerRadius(5)

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
