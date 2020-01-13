//
//  Ideas.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/11/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation
struct Idea: Decodable{
    let date: String
    let _id: String
    let title: String
    let details: String
    let user: String
}
