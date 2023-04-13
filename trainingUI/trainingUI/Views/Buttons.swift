//
//  SwiftUIView.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 3/28/23.
//

import SwiftUI

struct MainScreenButton: View {
    
    var isActive: Bool
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .frame(width: 40, height: 40)
            .font(.title2)
            .foregroundColor(.white)
            .scaleEffect(isActive ? 1.25 : 1)
            .background(isActive ? LinearGradient.ButtonGradient(for: .buttonON) : LinearGradient.ButtonGradient(for: .buttonOFF))
            .clipShape(Circle())
            .overlay(Circle().stroke( isActive ? LinearGradient.ButtonGradient(for: .buttonONBorder) : LinearGradient.ButtonGradient(for: .buttonOFFBorder), lineWidth: 5))
    }
}

struct RegularButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 40, height: 40)
            .font(.title2)
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 1.25 : 1)
            .background(configuration.isPressed ? LinearGradient.ButtonGradient(for: .buttonON) : LinearGradient.ButtonGradient(for: .buttonOFF))
            .clipShape(Circle())
            .overlay(Circle().stroke( configuration.isPressed ? LinearGradient.ButtonGradient(for: .buttonONBorder) : LinearGradient.ButtonGradient(for: .buttonOFFBorder), lineWidth: 5))
            .animation(.easeInOut(duration: 0.5), value: configuration.isPressed)
    }
}
