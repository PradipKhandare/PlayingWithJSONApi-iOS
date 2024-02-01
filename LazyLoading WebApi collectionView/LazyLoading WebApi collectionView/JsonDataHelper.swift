//
//  JsonDataHelper.swift
//  LazyLoading WebApi collectionView
//
//  Created by NTS on 01/02/24.
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
