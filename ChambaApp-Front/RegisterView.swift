//
//  RegisterView.swift
//  ChambaApp-Front
//
//  Created by Grecia Navarrete on 10/06/25.
//

import SwiftUI

struct RegisterView: View {
    var onRegisterSuccess: () -> Void
    var onBackToLogin: () -> Void

    @State private var name = ""
    @State private var address = ""
    @State private var birthdate = ""

    @State private var showImagePicker = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedUIImage: UIImage? = nil

    var body: some View {
        ZStack {
            Color("FondoPrincipal").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Text("REGISTRO")
                        .font(.largeTitle)
                        .foregroundColor(Color("TextoPrincipal"))
                        .padding(.top, 40)

                    ZStack {
                        Rectangle()
                            .fill(Color("FondoTarjeta"))
                            .frame(height: 140)
                            .cornerRadius(8)

                        if let uiImage = selectedUIImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 140)
                                .cornerRadius(8)
                        } else {
                            Text("INE")
                                .foregroundColor(Color("TextoPrincipal"))
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal, 30)

                    HStack(spacing: 20) {
                        Button("Galería") {
                            imageSource = .photoLibrary
                            showImagePicker = true
                        }
                        Button("Cámara") {
                            imageSource = .camera
                            showImagePicker = true
                        }
                    }
                    .foregroundColor(Color("TextoPrincipal"))

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Registro manual")
                            .foregroundColor(Color("TextoPrincipal"))

                        Group {
                            TextField("Nombre", text: $name)
                            TextField("Domicilio", text: $address)
                            TextField("Fecha de nacimiento", text: $birthdate)
                        }
                        .padding()
                        .background(Color("FondoTarjeta"))
                        .foregroundColor(Color("TextoPrincipal"))
                        .cornerRadius(5)
                    }
                    .padding(.horizontal, 30)

                    Button("Registrarme") {
                        onRegisterSuccess()
                    }
                    .foregroundColor(Color("TextoPrincipal"))
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Color("BotonPrimario"))
                    .cornerRadius(8)

                    Button("¿Ya tienes cuenta? Inicia sesión") {
                        onBackToLogin()
                    }
                    .foregroundColor(Color("TextoPrincipal"))
                    .font(.footnote)
                    .padding(.top, 10)

                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedUIImage, sourceType: imageSource)
        }
    }
}
