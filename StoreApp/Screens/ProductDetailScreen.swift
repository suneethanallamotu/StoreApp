//
//  ProductDetailScreen.swift
//  StoreApp
//
//  Created by Suneetha Nallamotu on 2/8/23.
//

import SwiftUI

struct ProductDetailScreen: View {
    let product: Product
    init(product: Product){
        self.product = product
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ScrollView(.horizontal){
                HStack{
                    ForEach(product.images ?? [], id:\.self) {imageUrl in
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                                .frame(maxWidth: 100, maxHeight: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            
                        } placeholder: {
                            ProgressView()
                        }
                        
                    }
                }
            }
            Text(product.description)
            Text(product.price, format: .currency(code: Locale.currencyCode))
                .borderedCaption()
            Spacer()
        }
        .padding()
        .navigationTitle(product.title)
    }
}

struct ProductDetailScreen_Previews: PreviewProvider {
   
    static var previews: some View {
        ProductDetailScreen(product: Product(title: "testprod", price: 2.0, description: "test", category: Category(id: 1, name: "elctronics", image: URL(string:"https://placeimg.com/640/480/any?r=0.9178516507833767")!), images:[URL(string:"https://placeimg.com/640/480/any?r=0.9178516507833767")!,URL(string:"https://placeimg.com/640/480/any?r=0.9178516507833767")!]))
    }
}
