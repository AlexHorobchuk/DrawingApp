//
//  Extensions.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 3/27/23.
//

import SwiftUI

extension LinearGradient {
    
    enum ButtonStatus {
        case buttonON, buttonOFF, buttonONBorder, buttonOFFBorder
    }
    
    static func ButtonGradient(for status: ButtonStatus) -> LinearGradient {
        switch status {
        case .buttonON:
            return LinearGradient(colors: [.blue, .yellow , .green, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .buttonOFF:
            return LinearGradient(colors: [ .yellow, .orange, .pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .buttonOFFBorder:
            return LinearGradient(colors: [ .yellow, .orange, .pink, .purple], startPoint: .bottomTrailing, endPoint: .topLeading)
        case .buttonONBorder:
            return LinearGradient(colors: [.blue, . green, .mint], startPoint: .bottomTrailing, endPoint: .topLeading)
        }
    }
    
    static func BackgroundGradiant() -> LinearGradient {
        return LinearGradient(colors: [.black, .blue, .yellow, .orange, .cyan, .mint], startPoint: .topTrailing, endPoint: .bottomLeading)
    }
}


struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct ClearBackgroundViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
    }
}

extension View {
    func clearModalBackground() -> some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}

extension DrawingVM: Equatable {
    static func == (lhs: DrawingVM, rhs: DrawingVM) -> Bool {
        return lhs.getActiveParticle() == rhs.getActiveParticle()
    }
}

extension Particle: Equatable {
    static func == (lhs: Particle, rhs: Particle) -> Bool {
        return lhs.id == rhs.id &&
        lhs.scale == rhs.scale &&
        lhs.currentTexture == rhs.currentTexture &&
        lhs.width == rhs.width &&
        lhs.height == rhs.height &&
        lhs.scaleSpeed == rhs.scaleSpeed &&
        lhs.colors == rhs.colors &&
        lhs.density == rhs.density
    }
}

extension CustomUIColor: Equatable {
    static func == (lhs: CustomUIColor, rhs: CustomUIColor) -> Bool {
        return lhs.id == rhs.id && lhs.color == rhs.color 
    }
    
}

extension CGPoint {
    func distance(point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
    func middlePosition(between point: CGPoint) -> CGPoint {
        let positionX = (point.x + x) / 2
        let positionY = (point.y + y) / 2
        return CGPoint(x: positionX, y: positionY)
    }
}

extension Color: Identifiable {
    public var id: UUID {
        return UUID()
    }
}

extension UIColor {
    public var id: UUID {
        return UUID()
    }
}

protocol Reload: AnyObject {
    func reload()
}

