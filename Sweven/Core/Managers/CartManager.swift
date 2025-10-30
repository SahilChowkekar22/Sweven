//
//  CartManager.swift
//  Sweven
//
//  Created by Sahil ChowKekar on 10/30/25.
//


import Foundation
import Combine

@MainActor
class CartManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Int = 0
    @Published var paymentSuccess = false
    @Published var error: CartError?          

    let paymentHandler = PaymentHandler()

    func addToCart(product: Product) {
        products.append(product)
        total += product.price
    }

    func removeFromCart(product: Product) {
        guard products.contains(where: { $0.id == product.id }) else {
            error = .invalidProduct
            return
        }
        products.removeAll { $0.id == product.id }
        total -= product.price
    }

    func pay() {
        guard !products.isEmpty else {
            error = .emptyCart
            return
        }

        paymentHandler.startPayment(products: products, total: total) { success in
            DispatchQueue.main.async {
                if success {
                    self.paymentSuccess = true
                    self.products = []
                    self.total = 0
                } else {
                    self.error = .paymentFailed
                }
            }
        }
    }
}
