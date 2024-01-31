//
//  JsonHelperFile.swift
//  Access images Data Using Json File On Web Server collectionView - 8
//
//  Created by NTS on 31/01/24.
//

import Foundation

struct JsonHelperFile : Codable
{
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
