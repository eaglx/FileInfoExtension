//
//  FileInfoMenu.swift
//  FinderSyncExtension
//
//  Created by eaglx on 30/12/2020.
//

import FinderSync

class FinderSync: FIFinderSync {

    override init() {
        super.init()

        // Set up the directory we are syncing.
        // We set up /, so we will monitor all directories.
        FIFinderSyncController.default().directoryURLs = [URL(fileURLWithPath: "/")]
    }

    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        // Produce a menu for the extension.
        let menu = FileInfoMenu(title: "FileInfo")
        menu.setInfo(
            with: FIFinderSyncController.default().selectedItemURLs(),
            resources: [.fileSize, .fileAllocatedSize, .totalFileSize, .totalFileAllocatedSize]
        )
        return menu
    }
}
