//
//  language_switcherApp.swift
//  language-switcher
//
//  Created by Amir Sarsenov on 20/04/2024.
//

import SwiftUI
import InputMethodKit

@main
struct LanguageSwitcherApp: App {
    @ObservedObject var appMonitor = AppMonitor()
    
    var body: some Scene {
        MenuBarExtra("Language Switcher", systemImage: "character.phonetic") {}
    }
}
