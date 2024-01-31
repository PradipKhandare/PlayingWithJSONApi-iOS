//
//  JsonDataHandler.swift
//  Activity Indicator - 1
//
//  Created by NTS on 31/01/24.
//

import Foundation

struct JsonDataHandler: Codable
{
    let albumId: Int
    let id: Int
    let title: String
    let thumbnailUrl: String
    let url: String
}
