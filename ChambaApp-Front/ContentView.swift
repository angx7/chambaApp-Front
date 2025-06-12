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
    case servicios
}

struct ContentView: View {
    @State private var currentScreen: AppScreen = .login

    var body: some View {
        NavigationView {
            switch currentScreen {
            case .login:
                LoginView(onLoginSuccess: {
                    currentScreen = .servicios
                }, onRegisterTap: {
                    currentScreen = .register
                })
            case .register:
                RegisterView(onRegisterSuccess: {
                    currentScreen = .servicios
                }, onBackToLogin: {
                    currentScreen = .login
                })
            case .servicios:
                ServiciosView(onLogout: {
                    currentScreen = .login
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
