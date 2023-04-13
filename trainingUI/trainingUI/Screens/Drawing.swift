//
//  ContentView.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 3/18/23.



import SwiftUI
import SpriteKit

struct Drawing: View {
    @StateObject var dravingVM = DrawingVM()
    
    var body: some View {
        ZStack {
            BGGradient(gradient: $dravingVM.backgroundPicker)
            GeometryReader { gr in
                DrawingSpriteView(viewModel: dravingVM, size: .zero)
                    .frame(width: gr.size.width, height: gr.size.height)
            }
            .ignoresSafeArea()
            
            VStack(alignment: .trailing) {
                Spacer()
                if !dravingVM.observationModeOn {
                    VStack {
                        if dravingVM.isShowingPreSets && dravingVM.isDraving {
                            HStack {
                                ForEach(dravingVM.preSets) { samleParticle in
                                    SampleSpriteView(particle: samleParticle, size: .init(width: 80,
                                                                                          height: 80))
                                    .frame(width: 60,height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(LinearGradient.ButtonGradient(for: samleParticle.id == dravingVM.activeParticleID ? .buttonONBorder : .buttonOFFBorder), lineWidth: 3))
                                    .onTapGesture { dravingVM.activeParticleID = samleParticle.id }
                                    .padding(3)
                                }
                            }
                            .transition(.slide)
                        }
                        
                        HStack(spacing: 25) {
                            Button(action: { withAnimation(.easeInOut(duration: 0.5)) {
                                if dravingVM.isDraving == true {
                                    dravingVM.isShowingPreSets.toggle()
                                }
                                dravingVM.isDraving = true
                            }},
                                   label: { MainScreenButton(isActive: dravingVM.isDraving ,
                                                             imageName: "wand.and.stars") })
                            
                            Button(action: { withAnimation(.easeInOut(duration: 1)) {
                                dravingVM.isDraving = false
                                dravingVM.isShowingPreSets = false
                            }},
                                   label: { MainScreenButton(isActive: !dravingVM.isDraving ,
                                                             imageName: "eraser") })
                            
                            Button(action: { dravingVM.restart?() },
                                   label: { Label("", systemImage: "arrow.triangle.2.circlepath")
                                    .offset(x: 4)
                            })
                            .buttonStyle(RegularButton())
                            
                            Button(action: { withAnimation(.easeInOut(duration: 1)) {
                                dravingVM.isShowingBGPicker = true }},
                                   label: { MainScreenButton(isActive: dravingVM.isShowingBGPicker ,
                                                             imageName: "photo") })
                            .fullScreenCover(isPresented: $dravingVM.isShowingBGPicker) {
                                BGPickerDetailView(isShowingBGPicker: $dravingVM.isShowingBGPicker,
                                                   bgPicker: $dravingVM.backgroundPicker,
                                                   selectedColor: dravingVM.backgroundPicker.colors.first!)
                                .clearModalBackground()
                            }
                            
                            Button(action: { withAnimation(.easeInOut(duration: 1)) {
                                dravingVM.isShovingSettings = true }},
                                   label: { MainScreenButton(isActive: dravingVM.isShovingSettings ,
                                                             imageName: "paintpalette") })
                            .fullScreenCover(isPresented: $dravingVM.isShovingSettings) {
                                SettingsDetailView(settings: $dravingVM.preSets.first(where: { $0.id == dravingVM.activeParticleID })!,
                                                   isShowingSettings: $dravingVM.isShovingSettings,
                                                   selectedColor: (dravingVM.preSets.first(where: { $0.id == dravingVM.activeParticleID })?.colors.first)!)
                                .clearModalBackground()
                            }
                            
                            Button(action: { withAnimation(.easeInOut(duration: 0.5)) { dravingVM.observationModeOn = true }},
                                   label: { MainScreenButton(isActive: dravingVM.observationModeOn,
                                                             imageName: "eye") })
                        }
                        .padding()
                        .shadow(color: .gray,radius: 5)
                    }
                    .alert(item: $dravingVM.alerItem) { alertItem in
                        Alert(title: alertItem.title,
                              message: alertItem.message,
                              dismissButton: alertItem.dismissButton)
                    }
                    .transition(.move(edge: .bottom))
                }
            }
        }
    }
}



struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Drawing()
    }
}
