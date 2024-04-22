//
//  AppMonitor.swift
//  language-switcher
//
//  Created by Amir Sarsenov on 20/04/2024.
//

import SwiftUI
import InputMethodKit

class AppMonitor: ObservableObject {
    private var activeBundleIdentifier: String?
    private var selectedLayout: String?
    private var appLanguage: Dictionary<String, String?> = [:]

    init() {
        // Listen for applications change
        NSWorkspace.shared.notificationCenter.addObserver(forName: NSWorkspace.didActivateApplicationNotification, object: nil, queue: nil) { notification in
            self.updateActiveApplication()
        }
    }
    
    private func getLayoutsList() -> [TISInputSource] {
        guard let inputSourceNSArray = TISCreateInputSourceList(nil, false)?.takeRetainedValue() as NSArray? else {
            print("Failed to fetch input sources")
            return []
        }
        let inputSourceList = inputSourceNSArray as! [TISInputSource]
        let filteredInputSources = inputSourceList.filter { $0.isKeyboardInputSource && $0.isSelectable }
        return filteredInputSources
    }
    
    private func updateSelectedLayout() {
        let currentLayoutInputSource = TISCopyCurrentKeyboardLayoutInputSource()?.takeRetainedValue()
        selectedLayout = currentLayoutInputSource?.sourceLanguage
        // Save layout under specific app bundle identifier for later use
        if selectedLayout != nil, let bundleIdentifier = activeBundleIdentifier {
            if appLanguage[bundleIdentifier] == nil { appLanguage[bundleIdentifier] = selectedLayout }
        }
    }

    
    private func updateActiveApplication() {
        self.updateSelectedLayout()
        activeBundleIdentifier = NSWorkspace.shared.frontmostApplication?.bundleIdentifier
        if let bundleIdentifier = activeBundleIdentifier, let activeApplicationKeyboardLayout = appLanguage[bundleIdentifier] {
            let inputSources = self.getLayoutsList()
            if inputSources.isEmpty { return }
            guard let inputSource = inputSources.first(where: { $0.sourceLanguage == activeApplicationKeyboardLayout }) else { return }
            TISSelectInputSource(inputSource)
        }
    }
}
