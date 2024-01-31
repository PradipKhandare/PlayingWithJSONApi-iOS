//
//  JsonDataHelper.swift
//  Access random images Data Using Json File On Web Server - 9
//
//  Created by NTS on 31/01/24.
//

import Foundation

struct JsonDataHelper: Codable
{
    let id: Int
    let albumId: Int
    let url: String
    let title: String
    let thumbnailUrl: String
}
