//
//  ContentView.swift
//  language-switcher
//
//  Created by Amir Sarsenov on 20/04/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var appMonitor: AppMonitor

    var body: some View {
        VStack {
            Text("Frontmost Application: \(appMonitor.frontmostAppName)")
                .padding()
        }
    }
}
