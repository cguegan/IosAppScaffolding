//
//  Bundle+AppVersion.swift
//  SwiftuiAuthBase
//
//  Created by Christophe Guégan on 13/07/2024.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
