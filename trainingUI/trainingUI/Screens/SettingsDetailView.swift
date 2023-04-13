//
//  ParticleDetailView.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 4/2/23.
//

import SwiftUI
import SpriteKit

struct SettingsDetailView: View {
    
    @Binding var settings: Particle
    @Binding var isShowingSettings: Bool
    @State var selectedColor: CustomUIColor
    var colors: [UIColor] = [.white, .black, .green, .blue, .red, .gray, .systemMint, .cyan, .orange, .yellow]
    
    
    var body: some View {
        VStack {
            
            GeometryReader { gr in
                SampleSpriteView(particle: settings, size: .zero)
                    .frame(width: gr.size.width, height: gr.size.height)
            }
            .frame(width: 120,height: 120)
            .clipShape(Circle())
            .padding(.top, 20)
            
            ScrollView {
                Text("Active colors:")
                    .foregroundColor(.white)
                    .offset(y: 10)
                    .padding(.top)
                HStack {
                    ForEach( settings.colors) { color in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(uiColor: color.color))
                            .frame(width: 70, height: 35)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(color.id == selectedColor.id ? .red : .white, lineWidth: 3))
                            .padding(4)
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                }
                
                Text("Change color to:")
                    .foregroundColor(.white)
                    .offset(y: 10)
                    .padding(.top)
                
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(Color(uiColor: color))
                                .frame(width: 36)
                                .overlay(Circle()
                                    .stroke(.white, lineWidth: 1))
                                .padding(1)
                                .onTapGesture {
                                    changeColor(color: color)
                                }
                        }
                    }
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                }
                
                
                SliderStack(value: $settings.density, topValue: 100, bottomValue: 10, name: "Density")
                SliderStack(value: $settings.scale, topValue: 1.1, bottomValue: 0.1, name: "Scale")
                SliderStack(value: $settings.scaleSpeed, topValue: 0.5, bottomValue: 0.1, name: "Scale speed")
                SliderStack(value: $settings.width, topValue: 40, bottomValue: 10, name: "Width")
                SliderStack(value: $settings.height, topValue: 40, bottomValue: 10, name: "Height")
            }
            
                Button(action: { isShowingSettings = false } ,
                       label: { Text("Done") })
                .buttonStyle(.bordered)
                .tint(.white)
                .padding()
        }
        .font(.system(size: 23))
        .frame(maxWidth: UIScreen.main.bounds.width * 0.85, maxHeight: UIScreen.main.bounds.height * 0.75)
        .background(.black)
        .opacity(0.75)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .ignoresSafeArea(edges: .top)
        .padding(.horizontal)
    }
    
    func changeColor(color: UIColor) {
        if let index = settings.colors.firstIndex(where: { $0.id == selectedColor.id }) {
            settings.colors[index].color = color
        }
    }
}
