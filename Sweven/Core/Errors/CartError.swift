//
//  CartError.swift
//  Sweven
//
//  Created by Sahil ChowKekar on 10/30/25.
//

import Foundation

enum CartError: LocalizedError, Identifiable {
    var id: String { localizedDescription }

    case emptyCart
    case paymentFailed
    case paymentCancelled
    case invalidProduct
    case networkIssue
    case unknown

    var errorDescription: String? {
        switch self {
        case .emptyCart:
            return "Your cart is empty. Please add some products before checkout."
        case .paymentFailed:
            return "Payment could not be completed. Please try again."
        case .paymentCancelled:
            return "Payment was cancelled."
        case .invalidProduct:
            return "Invalid product information found."
        case .networkIssue:
            return "There seems to be a network issue. Please check your connection."
        case .unknown:
            return "Something went wrong. Please try again later."
        }
    }
}

