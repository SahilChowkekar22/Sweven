//
//  ProductCard.swift
//  Sweven
//
//  Created by Sahil ChowKekar on 10/30/25.
//

import SwiftUI

struct ProductCard: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product

    var body: some View {
        ZStack(alignment: .topTrailing){
            ZStack(alignment: .bottom) {
                Image(product.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 250)
                    .clipped()
                    .cornerRadius(20)
                VStack(alignment: .leading){
                    Text(product.name)
                        .bold()
                    
                    Text("$\(product.price)")
                        .font(.caption)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(width: 180, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
            }
            .frame(width: 180, height: 250)
            .cornerRadius(20)
            .shadow(radius: 3)
            
            Button{
                cartManager.addToCart(product: product)
            } label:{
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(50)
                    .padding()
            }
        }
    }
}

#Preview {
    ProductCard(product: productList[0])
        .environmentObject(CartManager())
}
