//
//  FileInfoMenuItem.swift
//  FileInfoFinderExtension
//
//  Created by eaglx on 30/12/2020.
//

import Foundation

enum FileInfoMenuItem: String {
    case fileSize
    case fileAllocatedSize
    case totalFileSize
    case totalFileAllocatedSize
    
    var key: URLResourceKey {
        switch self {
        case .fileSize:
            return .fileSizeKey
        case .fileAllocatedSize:
            return .fileAllocatedSizeKey
        case .totalFileSize:
            return .totalFileSizeKey
        case .totalFileAllocatedSize:
            return .totalFileAllocatedSizeKey
        }
    }
    
    /// Name of the unit associated with a resource.
    var unit: String {
        switch self {
        case .fileSize,
             .fileAllocatedSize,
             .totalFileSize,
             .totalFileAllocatedSize:
            return "bytes"
        }
    }
}
