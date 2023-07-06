//
//  FileManager-DocumentDirectory.swift
//  RememberMe
//
//  Created by Tien Bui on 5/7/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
