//
//  CartView.swift
//  Sweven
//
//  Created by Sahil ChowKekar on 10/30/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        ScrollView {
            if cartManager.paymentSuccess {
                Text("Thanks for your purchase!")
                    .padding()
            } else if !cartManager.products.isEmpty {
                ForEach(cartManager.products, id: \.id) { product in
                    ProdcutRow(product: product)
                }
                HStack {
                    Text("Your cart total is")
                    Spacer()
                    Text("$\(cartManager.total).00").bold()
                }
                .padding()

                PaymentButton(action: cartManager.pay)
                    .padding()
            } else {
                Text("Your cart is empty")
            }
        }
        .navigationTitle("My Cart")
        .padding(.top)
        .alert(item: $cartManager.error) { error in     
            Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager())
}
