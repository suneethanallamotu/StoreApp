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
    @Environment(\.dismiss) var dismiss
    
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
            .pickerStyle(.wheel)
            TextField("Image URL", text: $imageURL)
        }
        .navigationTitle("Add Product")
        .onAppear {
            selectedCategory = storeModel.categories.first
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    saveProduct()
                }
                .disabled(isDoneDisabled)
            }
        }
    }
    private var isDoneDisabled: Bool {
        
        title.isEmpty || price == 0.0 || description.isEmpty ||
            selectedCategory == nil ||
            imageURL.isEmpty
         
    }
    
    private func saveProduct() {
        guard let category = selectedCategory,
              let imageURL = URL(string: imageURL) else {
            return
        }
        let createProductRequest = CreateProductRequest(title: title, price: price, description: description, categoryId: category.id, images: [imageURL])
        Task {
            do {
                try await storeModel.saveProduct(createProductRequest)
                dismiss()
            } catch {
                errorMessage = "Error saving the product"
            }
        }
    }
}

struct AddProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        let storeModel = StoreModel()
        storeModel.categories = [
            Category(id: 1, name: "Clothes", image: URL(string: "https://placeimg.com/640/480/any?r=0.9178516507833767")!),
            Category(id: 2, name: "Electronics", image: URL(string: "https://placeimg.com/640/480/any?r=0.9178516507833767")!),
            Category(id: 3, name: "Furniture", image: URL(string: "https://placeimg.com/640/480/any?r=0.9300320592588625")!)
        ]
        return
        NavigationStack {
            AddProductScreen()
                .environmentObject(storeModel)
        }
    }
}
