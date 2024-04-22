//
//  AppDelegate.swift
//  language-switcher
//
//  Created by Amir Sarsenov on 20/04/2024.
//
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var popover = NSPopover()
    var statusBar: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContentView(appMonitor: AppMonitor())
        popover.contentSize = NSSize(width: 200, height: 100)
        popover.contentViewController = NSHostingController(rootView: contentView)

        statusBar = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusBar?.button {
            button.image = NSImage(systemSymbolName: "gearshape", accessibilityDescription: nil)
            button.action = #selector(togglePopover(_:))
        }
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            if let button = statusBar?.button {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
