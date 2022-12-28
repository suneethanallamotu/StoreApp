//
//  CreateProductRequest.swift
//  StoreApp
//
//  Created by Suneetha Nallamotu on 12/28/22.
//

import Foundation

struct CreateProductRequest: Codable {
    let title: String
    let price: Double
    let description: String
    let categoryId: Int
    let images: [URL]
}
