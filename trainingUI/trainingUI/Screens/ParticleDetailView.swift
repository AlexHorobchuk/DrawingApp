//
//  ParticleDetailView.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 4/2/23.
//

import SwiftUI

struct SettingsDetailView: View {
    
    var settings: ParticleSettings
    @Binding var isShowingSettings: Bool
    
    var body: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .opacity(0.65)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .ignoresSafeArea(edges: .top)
        .padding(.horizontal)
        .presentationDetents(.init([.fraction(0.7)]))
        .presentationDragIndicator(.visible)
    }
}

struct ParticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDetailView(settings: ParticleSettings(), isShowingSettings: .constant(true))
    }
}
