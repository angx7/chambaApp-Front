//
//  FormFieldModifier.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 18/06/25.
//

import SwiftUI

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

