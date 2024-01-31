//
//  JsonHelper.swift
//  Access Data Using Json File On Web Server tableView - 6
//
//  Created by NTS on 31/01/24.
//

import Foundation

struct JsonHelper: Codable
{
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
