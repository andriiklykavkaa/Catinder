//
//  Breed.swift
//  Catinder
//
//  Created by Andrii Klykavka on 13.11.2024.
//

import Foundation

struct Image: Codable {
    let url: String?
}

struct Breed: Codable {
    let id: String
    let name: String
    let temperament: String?
    let origin: String?
    let image: Image?
}
