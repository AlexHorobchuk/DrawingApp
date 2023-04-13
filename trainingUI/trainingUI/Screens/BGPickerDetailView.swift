//
//  BackgroundPicker.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 4/2/23.
//

import SwiftUI

struct BGPickerDetailView: View {
    @Binding var isShowingBGPicker: Bool
    @Binding var bgPicker: GradientPicker
    @State var selectedColor: CustomColor
    @State var isShowingColorPicker = false
    var colors: [Color] = [.white, .black, .green, .blue, .red, .gray, .mint, .cyan, .orange, .yellow]
    
    
    var body: some View {
        VStack {
            VStack{
                Text("Background style:")
                    .padding(.top)
                Picker("Background Style", selection: $bgPicker.gradientType) {
                    ForEach( GradientType.allCases, id: \.self) {
                        Text($0.name)
                            .tag($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .font(.system(size: 25))
            }
            
            Text("Active colors:")
                .offset(y: 10)
                .padding(.top)
            
            ScrollView(.horizontal) {
                    HStack {
                        Button(action: { bgPicker.colors.insert(CustomColor(color: .white), at: 0) } ) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.secondary)
                                .frame(width: 80, height: 45)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 3))
                                .overlay(Text("add"))
                                .padding(4)
                        }
                        
                        ForEach( bgPicker.colors) { color in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(color.color)
                                .frame(width: 80, height: 45)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(color.id == selectedColor.id ? .red : .white, lineWidth: 3))
                                .padding(4)
                                .onTapGesture {
                                    selectedColor = color
                                }
                        }
                    }
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                }
            
            Text("Change color to:")
                .offset(y: 10)
                .padding(.top)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach( colors) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 35)
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
            
            HStack {
                
                Button(action: { removeColor() } ,
                       label: { Text("remove")
                        .frame(width: 120)
                        .foregroundColor(bgPicker.colors.count > 1 ? .white : .black)
                })
                .buttonStyle(.bordered)
                .tint(bgPicker.colors.count > 1 ? .white : .black)
                .padding()
                
            }
            
            
            
            Button(action: { isShowingBGPicker = false } ,
                   label: { Text("Done") })
            .buttonStyle(.bordered)
            .tint(.white)
            .padding()
        }
        .foregroundColor(.white)
        .font(.system(size: 23))
        .frame(maxWidth: UIScreen.main.bounds.width * 0.85, maxHeight: UIScreen.main.bounds.height * 0.75)
        .background(.black)
        .opacity(0.75)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .ignoresSafeArea(edges: .top)
        .padding()
    }
    
    func changeColor(color: Color) {
        if let index = bgPicker.colors.firstIndex(where: { $0.id == selectedColor.id }) {
            bgPicker.colors[index].color = color
        }
    }
    
    func removeColor() {
        if bgPicker.colors.count > 1 {
            bgPicker.colors.removeAll(where: { $0.id == selectedColor.id })
        }
    }
    
}

struct BackgroundPicker_Previews: PreviewProvider {
    static var previews: some View {
        BGPickerDetailView( isShowingBGPicker: .constant(true), bgPicker: .constant(GradientPicker(gradientType: .linear)), selectedColor: (CustomColor(color: .white)))
    }
}
