//
//  BorderedCaption.swift
//  StoreApp
//
//  Created by Suneetha Nallamotu on 2/8/23.
//

import Foundation
import SwiftUI

struct BorderedCaption: ViewModifier {
    private var backgroundColor: Color
    private var foregroundColor: Color
    init(backgroundColor: Color = Color.green, foregroundColor: Color = Color.white){
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    func body(content: Content) -> some View {
        content.padding(5)
            .foregroundColor(.white)
            .background {
                Color.green
            }
            .clipShape(RoundedRectangle(cornerRadius:10.0, style: .continuous))
    }
}
