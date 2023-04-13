//
//  Coordinator.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 4/5/23.
//

import Foundation

import SpriteKit
import SwiftUI

//MARK: Coordinator for SKScene

struct DrawingSpriteView: UIViewRepresentable {
    @ObservedObject var viewModel: DrawingVM
    let size: CGSize

    func makeUIView(context: Context) -> SKView {
        let view = SKView(frame: CGRect(origin: .zero, size: size))
        let scene = DrawingScene(viewModel: viewModel, size: size)
        scene.scaleMode = .resizeFill
        view.presentScene(scene)
        return view
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        if context.coordinator.viewModel != viewModel {
            context.coordinator.viewModel = viewModel
            let scene = DrawingScene(viewModel: viewModel, size: size)
            scene.scaleMode = .resizeFill
            uiView.presentScene(scene)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    class Coordinator: NSObject {
        var viewModel: DrawingVM

        init(viewModel: DrawingVM) {
            self.viewModel = viewModel
        }
    }
}

struct SampleSpriteView: UIViewRepresentable {
    var particle: Particle
    let size: CGSize

    func makeUIView(context: Context) -> SKView {
        let view = SKView(frame: CGRect(origin: .zero, size: size))
        let scene = SampleScene(modelSample: particle, size: size)
        scene.scaleMode = .resizeFill
        view.presentScene(scene)
        return view
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        if context.coordinator.particle != particle {
            context.coordinator.particle = particle
            let scene = SampleScene(modelSample: particle, size: size)
            scene.scaleMode = .resizeFill
            uiView.presentScene(scene)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(particle: particle)
    }

    class Coordinator: NSObject {
        var particle: Particle

        init(particle: Particle) {
            self.particle = particle
        }
    }
}
