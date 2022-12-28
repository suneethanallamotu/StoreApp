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
    @Published  var categories: [Category] = []
    @Published  var products: [Product] = []
    
    func fetchCategories() async throws {
        categories = try await client.load(Resource(url: URL.allCategogies))
        //categories = try await client.getCategories(url: URL.allCategogies)
    }
    
    func fetchProductsByCategory(_ categoryId: Int) async throws {
        products = try await client.load(Resource(url: URL.productsByCategories(categoryId)))
        //products = try await client.getProductsByCategory(url: URL.productsByCategories(categoryId))
    }
    
    func saveProduct(_ createProductRequest: CreateProductRequest) async throws {
        
        let data = try JSONEncoder().encode(createProductRequest)
        let product: Product = try await client.load(Resource(url: .saveProduct, method: .post(data)))
        products.append(product)
    }
}
