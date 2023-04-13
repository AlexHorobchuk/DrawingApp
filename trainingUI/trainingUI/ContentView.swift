//
//  ContentView.swift
//  trainingUI
//
//  Created by Olha Dzhyhirei on 3/18/23.
//

import SwiftUI

struct Main: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
