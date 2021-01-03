//
//  FileInfoMenu.swift
//  FinderSyncExtension
//
//  Created by eaglx on 30/12/2020.
//

import Cocoa

final class FileInfoMenu: NSMenu {
    
    /// A menu shown after moving a cursor over the main dropdown item.
    private let subMenu: NSMenu
    
    // MARK: - Initializers
    
    override init(title: String) {
        subMenu = NSMenu()
        super.init(title: title)
        
        let mainDropdown = NSMenuItem(title: title)
        addItem(mainDropdown)
        setSubmenu(subMenu, for: mainDropdown)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal methods
    
    /// Creates a menu for given URLs, consisting of requested resource information.
    func setInfo(with urls: [URL]?, resources: [FileInfoMenuItem]) {
        subMenu.removeAllItems()
        
        guard
            let currentUrlArray = urls,
            !currentUrlArray.isEmpty,
            !resources.isEmpty
        else {
            let menuItem = NSMenuItem(title: "No data available")
            menuItem.isEnabled = false
            subMenu.addItem(menuItem)
            return
        }
        
        resources.forEach { resource in
            subMenu.addItem(
                NSMenuItem(title: resource.toString(with: currentUrlArray))
            )
        }
    }
}

// MARK: - Fileprivate extensions

fileprivate extension FileInfoMenuItem {
    func sumResourceValues(of urlArray: [URL]) -> Int {
        urlArray.map {
            $0.resourceValue(for: key)
        }.reduce(0, +)
    }
    
    func toString(with urlArray: [URL]) -> String {
        "\(rawValue): \(sumResourceValues(of: urlArray)) \(unit)"
    }
}

fileprivate extension URL {
    func resourceValue(for resourceKey: URLResourceKey) -> Int {
        var urlSizes: Int = 0
        
        if let res = try? resourceValues(forKeys: [resourceKey]) {
            urlSizes += res.allValues[resourceKey] as? Int ?? 0
        }
        
        return urlSizes
    }
}

fileprivate extension NSMenuItem {
    convenience init(title: String) {
        self.init(title: title, action: nil, keyEquivalent: "")
    }
}
