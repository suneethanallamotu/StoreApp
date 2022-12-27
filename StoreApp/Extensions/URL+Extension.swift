//
//  URL+Extension.swift
//  StoreApp
//
//  Created by Suneetha Nallamotu on 12/23/22.
//

import Foundation

extension URL {
    static var development: URL {
        URL(string: "https://api.escuelajs.co")!
    }
    static var production: URL {
        URL(string: "https://api.escuelajs.co")!
    }
    
    static var baseURL: URL {
        #if DEBUG
            return development
        #else
            return production
        #endif
    }
    static var allCategogies: URL {
        URL(string: "/api/v1/categories", relativeTo: Self.baseURL)!
    }
    static func productsByCategories(_ categoryId: Int) -> URL {
        return URL(string: "/api/v1/categories/\(categoryId)/products", relativeTo: Self.baseURL)!
    }
}
