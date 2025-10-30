//
//  ProdcutRow.swift
//  Sweven
//
//  Created by Sahil ChowKekar on 10/30/25.
//

import SwiftUI

struct ProdcutRow: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    var body: some View {
        HStack(spacing:20){
            Image(product.image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10){
                Text(product.name)
                    .bold()
                
                Text("$\(product.price)")
            }
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                .onTapGesture {
                    cartManager.removeFromCart(product: product)
                }
            
            
        }
        .padding()
    }
}

#Preview {
    ProdcutRow(product: productList[3])
        .environmentObject(CartManager())
}
