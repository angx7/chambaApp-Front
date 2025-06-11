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
            Color(red: 26/255, green: 62/255, blue: 66/255).ignoresSafeArea()
            VStack(spacing: 24) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .padding(.top, 50)

                HStack {
                    Image(systemName: "person").foregroundColor(.black)
                    TextField("username", text: $username).foregroundColor(.white)
                }
                .padding()
                .background(Color(red: 114/255, green: 153/255, blue: 156/255))
                .cornerRadius(5)
                .padding(.horizontal, 30)

                HStack {
                    Image(systemName: "lock").foregroundColor(.black)
                    SecureField("password", text: $password).foregroundColor(.white)
                }
                .padding()
                .background(Color(red: 114/255, green: 153/255, blue: 156/255))
                .cornerRadius(5)
                .padding(.horizontal, 30)

                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .foregroundColor(.white)

                Button("LOGIN") {
                    // Aquí puedes validar credenciales
                    onLoginSuccess()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 200)
                .background(Color(red: 114/255, green: 153/255, blue: 156/255))
                .cornerRadius(5)

                Button("¿No tienes cuenta? Regístrate") {
                    onRegisterTap()
                }
                .font(.footnote)
                .foregroundColor(.white)
                .underline()
                .padding(.top, 10)

                Spacer()
            }
        }
    }
}
