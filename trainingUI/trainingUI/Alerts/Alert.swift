//
//  Alert.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 4/8/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let nodeLimit = AlertItem(title: Text("You have exceed the limit"),
                                     message: Text("Please dealete some of your droving or refresh the screen"),
                                     dismissButton: .default(Text("OK")))
}

