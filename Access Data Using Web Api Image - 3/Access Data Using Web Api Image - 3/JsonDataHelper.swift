//
//  File.swift
//  Access Data Using Web Api Image - 3
//
//  Created by NTS on 30/01/24.
//

import Foundation

struct JsonDataHelper: Codable
{
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
