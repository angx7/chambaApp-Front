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
            Color(red: 26/255, green: 62/255, blue: 66/255).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Text("REGISTRO")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
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
                                .foregroundColor(.black)
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
                    .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Registro manual")
                            .foregroundColor(.white)

                        Group {
                            TextField("Nombre", text: $name)
                            TextField("Domicilio", text: $address)
                            TextField("Fecha de nacimiento", text: $birthdate)
                        }
                        .padding()
                        .background(Color(red: 206/255, green: 237/255, blue: 241/255))
                        .cornerRadius(5)
                    }
                    .padding(.horizontal, 30)

                    Button("Registrarme") {
                        // Aquí podrías guardar info, luego:
                        onRegisterSuccess()
                    }
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Color(red: 114/255, green: 153/255, blue: 156/255))
                    .cornerRadius(8)

                    Button("¿Ya tienes cuenta? Inicia sesión") {
                        onBackToLogin()
                    }
                    .foregroundColor(.white)
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
