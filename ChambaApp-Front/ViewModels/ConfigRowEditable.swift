//
//  ConfigRowEditable.swift
//  ChambaApp-Front
//
//  Created by Angel Becerra Rojas on 18/06/25.
//
import SwiftUI

struct ConfigRowEditable: View {
    var label: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            
            TextField(label, text: $value)
                .font(.body)
                .foregroundColor(Color("TextoPrincipal"))
                .padding(8)
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)
        }
    }
}
