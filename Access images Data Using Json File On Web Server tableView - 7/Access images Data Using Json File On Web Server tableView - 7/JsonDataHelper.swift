//
//  JsonDataHelper.swift
//  Access images Data Using Json File On Web Server tableView - 7
//
//  Created by NTS on 31/01/24.
//

import Foundation

struct JsonDataHelper: Codable
{
    let albumId: Int
    let id: Int
    let url: String
    let thumbnailUrl: String
    let title: String
}
