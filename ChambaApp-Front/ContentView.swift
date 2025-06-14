//
//  ContentView.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 06/06/25.
//

import SwiftUI

enum AppScreen {
    case login
    case register
}

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @State private var currentScreen: AppScreen = .login

    var body: some View {
        NavigationView {
            if isLoggedIn {
                ServiciosView(onLogout: {
                    isLoggedIn = false
                })
            } else {
                switch currentScreen {
                case .login:
                    LoginView(onLoginSuccess: {
                        isLoggedIn = true
                    }, onRegisterTap: {
                        currentScreen = .register
                    })
                case .register:
                    RegisterView(onRegisterSuccess: {
                        isLoggedIn = true
                    }, onBackToLogin: {
                        currentScreen = .login
                    })
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
