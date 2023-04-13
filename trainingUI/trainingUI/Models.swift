//
//  File.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 3/25/23.
//

import Foundation
import SwiftUI

class DrawingVM: ObservableObject {
    @Published var activeParticleID: UUID = MockPreSets.particals.first!.id
    @Published var isDraving = true
    @Published var preSets: [Particle] = MockPreSets.particals
    @Published var backgroundPicker = GradientPicker()
    @Published var isShowingPreSets = false
    @Published var isShowingBGPicker = false
    @Published var isShovingSettings = false
    @Published var alerItem: AlertItem?
    @Published var observationModeOn = false
    var restart: (() -> Void)?
    var razorRadius = 15
    
    func nodeLimit() {
        alerItem = AlertContext.nodeLimit
    }
    
    func getActiveParticle() -> Particle {
        return preSets.first(where: {$0.id == activeParticleID})!
    }
}

struct Particle: Identifiable {
    var density: Double = 32
    var width: Double = 20
    var height: Double = 20
    var scale: Double = 0.35
    var scaleSpeed: Double = 0.2
    var id = UUID()
    var currentTexture: String
    var colors: [CustomUIColor]
}

struct CustomUIColor: Identifiable {
    var id = UUID()
    var color: UIColor
}

struct MockPreSets {
    static var particals = [Particle(currentTexture: "Spark", colors: [CustomUIColor(color: .systemMint),
                                                                       CustomUIColor(color: .yellow),
                                                                       CustomUIColor(color: .blue),
                                                                       CustomUIColor(color: .blue)]),
                            
                            Particle(currentTexture: "Magic", colors: [CustomUIColor(color: .blue),
                                                                       CustomUIColor(color: .systemMint),
                                                                       CustomUIColor(color: .white),
                                                                       CustomUIColor(color: .systemMint) ]),
                                                                       
                            Particle(currentTexture: "Smoke", colors: [CustomUIColor(color: .systemMint),
                                                                       CustomUIColor(color: .blue),
                                                                       CustomUIColor(color: .magenta),
                                                                       CustomUIColor(color: .green) ]),
                            
                            Particle(currentTexture: "Fire", colors: [CustomUIColor(color: .red),
                                                                      CustomUIColor(color: .orange),
                                                                      CustomUIColor(color: .yellow),
                                                                      CustomUIColor(color: .red) ]),
                                                                      
                            Particle(currentTexture: "FireFlies", colors: [CustomUIColor(color: .blue),
                                                                      CustomUIColor(color: .magenta),
                                                                      CustomUIColor(color: .blue),
                                                                      CustomUIColor(color: .magenta) ])]
}

struct GradientPicker {
    var gradientType: GradientType = .linear
    var colors: [CustomColor] = [CustomColor(color: .red),
                                  CustomColor(color: .black),
                                  CustomColor(color: .black),
                                  CustomColor(color: .black),
                                  CustomColor(color: .black),
                                  CustomColor(color: .red)]
    
    mutating func setType(_ type: GradientType) {
        switch type {
        case .linear:
            gradientType = .linear
        case .angular:
            gradientType = .angular
        case .radial:
            gradientType = .radial
        }
    }
}

struct CustomColor: Identifiable {
    var id = UUID()
    var color: Color
}

enum GradientType: CaseIterable {
    case linear, angular, radial
    var name : String {
        switch self {
        case .linear:
           return "Linear"
        case .angular:
           return "Angular"
        case .radial:
           return "Radial"
        }
    }
}


