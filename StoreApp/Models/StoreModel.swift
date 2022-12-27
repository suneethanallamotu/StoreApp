//
//  StoreModel.swift
//  StoreApp
//
//  Created by Suneetha Nallamotu on 12/23/22.
//

import Foundation

@MainActor
class StoreModel: ObservableObject {
    
    var client = StoreHttpclient()
    @Published private(set) var categories: [Category] = []
    @Published private(set) var products: [Product] = []
    
    func fetchCategories() async throws {
        categories = try await client.load(Resource(url: URL.allCategogies))
        //categories = try await client.getCategories(url: URL.allCategogies)
    }
    
    func fetchProductsByCategory(_ categoryId: Int) async throws {
        products = try await client.load(Resource(url: URL.productsByCategories(categoryId)))
        //products = try await client.getProductsByCategory(url: URL.productsByCategories(categoryId))
    }
}
