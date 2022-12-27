//
//  AddProductScreen.swift
//  StoreApp
//
//  Created by Suneetha Nallamotu on 12/27/22.
//

import SwiftUI

struct AddProductScreen: View {
    @State private var title: String = ""
    @State private var price: Double = 0.0
    @State private var description: String = ""
    @State private var selectedCategory: Category?
    @State private var imageURL: String = ""
    @State private var errorMessage: String = ""
    @EnvironmentObject var storeModel: StoreModel
    
    var body: some View {
        Form {
            TextField("Enter Title", text: $title)
            TextField("Enter Price", value: $price, format: .number)
            TextField("Enter Description", text: $description)
            
            Picker("Categories", selection: $selectedCategory) {
                ForEach(storeModel.categories, id: \.id){ category in
                    Text(category.name)
                    
                }
            }
            .pickerStyle(.automatic)
        }
    }
}

struct AddProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        let storeModel = StoreModel()
        storeModel.categories = [
            Category(id: 1, name: "Clothes", image: URL(string: "https://placeimg.com/640/480/any?r=0.9178516507833767")!),
            Category(id: 1, name: "Clothes", image: URL(string: "https://placeimg.com/640/480/any?r=0.9178516507833767")!),
            Category(id: 1, name: "Clothes", image: URL(string: "https://placeimg.com/640/480/any?r=0.9300320592588625")!)
        ]
        return
        AddProductScreen()
            .environmentObject(storeModel)
    }
}
