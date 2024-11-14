//
//  Cat.swift
//  Catinder
//
//  Created by Andrii Klykavka on 13.11.2024.
//

import Foundation

struct Cat: Codable {
    let id: String
    let url: String
}

var likedCats: [Cat] = []
