//
//  ProductListScreen.swift
//  StoreApp
//
//  Created by Suneetha Nallamotu on 12/25/22.
//

import SwiftUI

struct ProductListScreen: View {
    let category: Category
    @EnvironmentObject var storeModel: StoreModel
    @State private var isProductAddPresented = false
    var body: some View {
        
        VStack {
            List(storeModel.products, id: \.id){ product in
               ProductCellView(product: product)
                
            }
            .navigationTitle(category.name)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    
                    Button("Add Product") {
                        isProductAddPresented = true
                    }
                }
            }
            .sheet(isPresented: $isProductAddPresented) {
                NavigationStack {
                    AddProductScreen()
                }
            }
            .task {
                do {
                    try await storeModel.fetchProductsByCategory(category.id)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}

struct ProductListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductListScreen(category: Category(id: 1, name: "some test", image: URL(string:"https://placeimg.com/640/480/any?r=0.9178516507833767")!))
            .environmentObject(StoreModel())
    }
}
