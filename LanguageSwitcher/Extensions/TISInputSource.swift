//
//  TISInputSource.swift
//  language-switcher
//
//  Created by Amir Sarsenov on 20/04/2024.
//

import Cocoa
import InputMethodKit

extension TISInputSource {
    private func getProperty(_ key: CFString) -> AnyObject? {
        guard let cfType = TISGetInputSourceProperty(self, key) else { return nil }
        return Unmanaged<AnyObject>.fromOpaque(cfType).takeUnretainedValue()
    }

    var id: String {
        return getProperty(kTISPropertyInputSourceID) as! String
    }

    var category: String {
        return getProperty(kTISPropertyInputSourceCategory) as! String
    }

    var isKeyboardInputSource: Bool {
        return category == (kTISCategoryKeyboardInputSource as String)
    }

    var isSelectable: Bool {
        return getProperty(kTISPropertyInputSourceIsSelectCapable) as! Bool
    }

    var isSelected: Bool {
        return getProperty(kTISPropertyInputSourceIsSelected) as! Bool
    }

    var sourceLanguage: String {
        guard let sourceLanguages = getProperty(kTISPropertyInputSourceLanguages) as? [String] else { return "en" }
        return sourceLanguages[0]
    }
}
