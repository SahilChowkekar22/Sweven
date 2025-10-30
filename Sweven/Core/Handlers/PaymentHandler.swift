//
//  PaymentHandler.swift
//  Sweven
//
//  Created by Sahil ChowKekar on 10/30/25.
//
 

import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var completionHandler: PaymentCompletionHandler?

    static let supportedNetworks: [PKPaymentNetwork] = [.visa, .masterCard]
    
    func shippingmethodCalculator() -> [PKShippingMethod] {
        let today = Date()
        let calendar = Calendar.current
        
        let shippingStart = calendar.date(byAdding: .day, value: 5, to: today)
        let shippingEnd = calendar.date(byAdding: .day, value: 10, to: today)
        
        if let shippingEnd, let shippingStart {
            let startComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingStart)
            let endComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingEnd)
            
            let shippingDelivery = PKShippingMethod(label: "Delivery", amount: NSDecimalNumber(string:"0.00"))
            shippingDelivery.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)
            shippingDelivery.detail = "Sweater sent to your address"
            shippingDelivery.identifier = "DELIVERY"
            
            return [shippingDelivery]
        }
        return []
    }

    func startPayment(products: [Product], total: Int, completion: @escaping PaymentCompletionHandler) {
        completionHandler = completion

        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = "merchant.com.sahil.sweatershoppingapp"
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        paymentRequest.supportedNetworks = Self.supportedNetworks
        paymentRequest.merchantCapabilities = .threeDSecure
        paymentRequest.shippingType = .delivery
        paymentRequest.shippingMethods =  shippingmethodCalculator()
        paymentRequest.requiredShippingContactFields = [.name, .postalAddress]

        products.forEach { product in
            let item = PKPaymentSummaryItem(label: product.name, amount: NSDecimalNumber(string: "\(product.price).00"))
            paymentSummaryItems.append(item)
        }

        paymentSummaryItems.append(PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "\(total).00")))
        paymentRequest.paymentSummaryItems = paymentSummaryItems

        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self

        paymentController?.present { presented in
            if !presented {
                debugPrint("Failed to present payment controller")
                completion(false)
            }
        }
    }
}

extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }

    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            self.completionHandler?(true)
        }
    }
}
