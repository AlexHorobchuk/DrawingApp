//
//  SwiftUIView.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 4/5/23.
//

import SwiftUI

struct BGGradient: View {
    @Binding var gradient: GradientPicker
    
    var body: some View {
        GeometryReader { geometry in
            switch gradient.gradientType {
            case .linear:
                LinearGradient(
                    colors: getColors(),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                )
            case .angular:
                AngularGradient(colors: getColors(),
                                center: .center)
            case .radial:
                RadialGradient(
                    colors: getColors(),
                    center: .center,
                    startRadius: 420,
                    endRadius: 0
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        }
    
    func getColors() -> [Color] {
        return gradient.colors.map{ $0.color }
    }
    }

