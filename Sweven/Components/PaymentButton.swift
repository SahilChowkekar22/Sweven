//
//  PaymentButton.swift
//  Sweven
//
//  Created by Sahil ChowKekar on 10/30/25.
//

import SwiftUI
import PassKit

struct PaymentButton: View {
    var action: () -> Void
    var body: some View {
        Representable(action: action)
            .frame(minWidth: 100, maxWidth: 400)
            .frame(height: 45)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    PaymentButton(action: {})
}

extension PaymentButton {
    struct Representable: UIViewRepresentable {
        var action: () -> Void
        typealias UIViewType = PKPaymentButton
        
        func makeCoordinator() -> Coordinator {
            Coordinator(action: action)
        }
        
        func makeUIView(context: Context) -> PKPaymentButton {
            context.coordinator.button
        }
        
        func updateUIView(_ uiView: PKPaymentButton, context: Context) {
            context.coordinator.action = action
        }
    }
    
    class Coordinator: NSObject {
        var action: () -> Void
        var button = PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .automatic)
        
        init(action: @escaping () -> Void){
            self.action = action
            super.init()
            
            button.addTarget(self, action: #selector(callback(_:)), for: .touchUpInside)
        }
        
        @objc func callback(_ sender: Any){
            action()
        }
    }
     
}
