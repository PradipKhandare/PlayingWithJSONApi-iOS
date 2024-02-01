//
//  JsonDataHandler.swift
//  LazyLoading WebApi tableView
//
//  Created by NTS on 01/02/24.
//

import Foundation

struct JsonDataHandler: Codable
{
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
