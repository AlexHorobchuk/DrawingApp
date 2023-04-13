//
//  Scene.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 3/26/23.
//
import SpriteKit
import SwiftUI

class DrawingScene: SKScene {
    
    var viewModel: DrawingVM
    var lastPosition: CGPoint = .zero
    var path: UIBezierPath?
    var points: [CGPoint] = []
    init(viewModel: DrawingVM, size: CGSize) {
        self.viewModel = viewModel
        super.init(size: size)
        viewModel.restart = { [weak self] in
            self?.restart()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view?.allowsTransparency = true
        self.view?.backgroundColor = .clear
    }
    
    func restart() {
        self.removeAllChildren()
    }
    
    private func deleteParticles(at position: CGPoint) {
        guard let circle = self.childNode(withName: "erasor") else {
            let circle = SKShapeNode(circleOfRadius: CGFloat(viewModel.razorRadius))
            circle.name = "erasor"
            circle.fillColor = .clear
            circle.strokeColor = .white
            addChild(circle)
            return
        }
        circle.position = position
        self.children.forEach { node in
            if node != circle && circle.contains(node.position) {
                node.removeFromParent()
            }
        }
    }
    
    private func moveNodeAlongBezierPath(_ node: SKNode, bezierPath: UIBezierPath, duration: TimeInterval) {
        let followPath = SKAction.follow(bezierPath.cgPath, asOffset: false, orientToPath: true, duration: duration)
        node.run(.repeatForever(followPath))
    }
    
    private func createParticleNode(at position: CGPoint) {
        let particle = viewModel.getActiveParticle()
        let colors = particle.colors.map { $0.color }
        let colorSequence = SKKeyframeSequence(keyframeValues: colors, times: [0.1, 0.1, 0.15, 0.3])
        guard let node = SKEmitterNode(fileNamed: particle.currentTexture) else { return }
        node.position = position
        node.particleBirthRate = CGFloat(particle.density)
        node.particleScale = CGFloat(particle.scale)
        node.particleScaleSpeed = CGFloat(particle.scaleSpeed)
        node.particleSize.width = CGFloat(particle.width)
        node.particleSize.height = CGFloat(particle.height)
        node.particleColorSequence = colorSequence
        node.targetNode = self
        self.addChild(node)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            if viewModel.isDraving {
                if self.children.count > 1100 {
                    viewModel.nodeLimit() }
                else {
                    if position.distance(point: lastPosition) > 20 {
                        path = UIBezierPath()
                        path?.move(to: lastPosition)
                        createParticleNode(at: position)
                        path?.addLine(to: position)
                        guard let node = self.children.last else { return }
                        path?.lineJoinStyle = .round
                        moveNodeAlongBezierPath(node, bezierPath: path!, duration: 0.5)
                        path = nil
                        lastPosition = position
                    }
                }
            } else {
                deleteParticles(at: position)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if viewModel.observationModeOn {
                lastPosition = position
                withAnimation(.easeInOut(duration: 0.5)) {
                    viewModel.observationModeOn = false }} else {
                    if viewModel.isDraving {
                        viewModel.isShowingPreSets = false
                        if self.children.count > 1100 {
                            viewModel.nodeLimit() }
                        else {
                            createParticleNode(at: position)
                            lastPosition = position
                        }
                    } else {
                        deleteParticles(at: position)
                    }
                }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let circle = self.childNode(withName: "erasor") else { return }
            circle.removeFromParent()
    }
}
