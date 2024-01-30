//
//  DataFromJSON.swift
//  Access Data Using Web Api Covid-19 - 2
//
//  Created by NTS on 30/01/24.
//

import Foundation

struct DataFromJSON: Codable
{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
