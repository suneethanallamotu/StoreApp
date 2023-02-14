//
//  ProductCellView.swift
//  StoreApp
//
//  Created by Suneetha Nallamotu on 12/25/22.
//

import SwiftUI

struct ProductCellView: View {
    let product: Product
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .firstTextBaseline) {
                Text(product.title)
                    .bold()
                Spacer()
                Text(product.price, format: .currency(code: Locale.currencyCode))
                    .borderedCaption(backgroundColor: .green, foregroundColor: .white)
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.green)
//                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            }
            Text(product.description)
        }
    }
}

//struct ProductCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCellView()
//    }
//}
