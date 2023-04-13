//
//  sampleScene.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 3/29/23.
//

import SpriteKit

import UIKit
import GameplayKit

class SampleScene: SKScene{
    var sample: Particle
    
    init(modelSample: Particle, size: CGSize) {
        self.sample = modelSample
        super.init(size: size)
            
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        scene?.anchorPoint = .init(x: 0.5, y: 0.5)
        physicsBody = (SKPhysicsBody(edgeLoopFrom: frame))
        backgroundColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view?.allowsTransparency = true
        self.view?.backgroundColor = .clear
        createParticleNode()
    }
    
    private func createParticleNode() {
        guard let node = SKEmitterNode(fileNamed: sample.currentTexture) else { return }
        let colors = sample.colors.map { $0.color }
        let colorSequence = SKKeyframeSequence(keyframeValues: colors, times: [0.1, 0.1, 0.15, 0.3])
        node.particleBirthRate = CGFloat(sample.density)
        node.particleScale = CGFloat(sample.scale)
        node.particleScaleSpeed = CGFloat(sample.scaleSpeed)
        node.particleSize.width = CGFloat(sample.width)
        node.particleSize.height = CGFloat(sample.height)
        node.particleColorSequence = colorSequence
        self.addChild(node)
    }
        
}
