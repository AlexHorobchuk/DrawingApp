//
//  SwiftUIView.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 4/3/23.
//

import SwiftUI

struct SliderStack: View {
    @Binding var value: Double
    var topValue: Double
    var bottomValue: Double
    var name: String
    
    var body: some View {
            VStack {
                Text(name)
                    .offset(y: 10)
                    .foregroundColor(.white)
                Slider(value: $value, in: bottomValue...topValue)
                    .padding(.horizontal)
        }
        .frame(height: 50)
        .padding()
        
    }
}
