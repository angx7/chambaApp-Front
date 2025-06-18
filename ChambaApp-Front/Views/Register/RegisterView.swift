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

    @State private var nombreCompleto = ""
    @State private var domicilio = ""
    @State private var fechaNacimiento = ""
    @State private var cp = ""
    @State private var usuario = ""
    @State private var contrasena = ""
    @State private var confirmarContrasena = ""
    @State private var mostrarContrasena = false

    @State private var showImagePicker = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedUIImage: UIImage? = nil

    @State private var errorMessage = ""
    @State private var fieldErrors = [String: Bool]()

    @State private var isLoading = false
    @State private var showWelcomeAlert = false

    func validarCampos() -> Bool {
        fieldErrors = [
            "nombreCompleto": nombreCompleto.trimmingCharacters(in: .whitespaces).isEmpty,
            "domicilio": domicilio.trimmingCharacters(in: .whitespaces).isEmpty,
            "fechaNacimiento": fechaNacimiento.trimmingCharacters(in: .whitespaces).isEmpty,
            "cp": cp.count != 5,
            "usuario": usuario.trimmingCharacters(in: .whitespaces).isEmpty,
            "contrasena": contrasena.trimmingCharacters(in: .whitespaces).isEmpty,
            "confirmarContrasena": confirmarContrasena != contrasena
        ]

        if fieldErrors.values.contains(true) {
            if fieldErrors["cp"] == true {
                errorMessage = "El código postal debe tener 5 dígitos."
            } else if fieldErrors["confirmarContrasena"] == true {
                errorMessage = "Las contraseñas no coinciden."
            } else {
                errorMessage = "Por favor completa todos los campos."
            }
            return false
        }

        errorMessage = ""
        return true
    }

    func registrarUsuario() {
        isLoading = true

        let nuevoUsuario: [String: String] = [
            "nombreCompleto": nombreCompleto,
            "fechaNacimiento": fechaNacimiento,
            "domicilio": domicilio,
            "cp": cp,
            "usuario": usuario,
            "contrasena": contrasena
        ]

        AuthService.shared.register(usuario: nuevoUsuario) { success, mensaje in
            DispatchQueue.main.async {
                isLoading = false

                if success {
                    showWelcomeAlert = true
                } else {
                    errorMessage = mensaje ?? "Error al registrar usuario"
                }
            }
        }
    }

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

                        TextField("Nombre completo", text: $nombreCompleto)
                            .modifier(FormFieldModifier(invalid: fieldErrors["nombreCompleto"] ?? false))

                        TextField("Domicilio", text: $domicilio)
                            .modifier(FormFieldModifier(invalid: fieldErrors["domicilio"] ?? false))

                        TextField("Fecha de nacimiento", text: $fechaNacimiento)
                            .modifier(FormFieldModifier(invalid: fieldErrors["fechaNacimiento"] ?? false))

                        TextField("Código Postal", text: $cp)
                            .keyboardType(.numberPad)
                            .modifier(FormFieldModifier(invalid: fieldErrors["cp"] ?? false))

                        TextField("Usuario", text: $usuario)
                            .modifier(FormFieldModifier(invalid: fieldErrors["usuario"] ?? false))

                        HStack {
                            Group {
                                if mostrarContrasena {
                                    TextField("Contraseña", text: $contrasena)
                                } else {
                                    SecureField("Contraseña", text: $contrasena)
                                }
                            }
                            .id("contrasena-\(mostrarContrasena)") // 🔑 clave

                            Button(action: {
                                mostrarContrasena.toggle()
                            }) {
                                Image(systemName: mostrarContrasena ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .modifier(FormFieldModifier(invalid: fieldErrors["contrasena"] ?? false))

                        HStack {
                            Group {
                                if mostrarContrasena {
                                    TextField("Confirmar contraseña", text: $confirmarContrasena)
                                } else {
                                    SecureField("Confirmar contraseña", text: $confirmarContrasena)
                                }
                            }
                            .id("confirmar-\(mostrarContrasena)") // 🔑 clave también

                            Button(action: {
                                mostrarContrasena.toggle()
                            }) {
                                Image(systemName: mostrarContrasena ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .modifier(FormFieldModifier(invalid: fieldErrors["confirmarContrasena"] ?? false))

                    }
                    .padding(.horizontal, 30)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button {
                        if validarCampos() {
                            registrarUsuario()
                        }
                    } label: {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color("TextoPrincipal")))
                                .frame(maxWidth: 200)
                                .padding()
                        } else {
                            Text("Registrarme")
                                .foregroundColor(Color("TextoPrincipal"))
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: 200)
                                .background(Color("BotonPrimario"))
                                .cornerRadius(8)
                        }
                    }

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
        .alert("Bienvenido", isPresented: $showWelcomeAlert) {
            Button("OK") {
                onRegisterSuccess()
            }
        }
    }
}

struct FormFieldModifier: ViewModifier {
    var invalid: Bool

    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("FondoTarjeta"))
            .foregroundColor(Color("TextoPrincipal"))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(invalid ? Color.red : Color.clear, lineWidth: 1.5)
            )
    }
}
