//
//  ImageData.swift
//  Pinterest
//
//  Created by neelkant on 02/06/20.
//  Copyright © 2020 appscrip. All rights reserved.
//

import Foundation
// MARK: - ImageData
struct ImageData: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
