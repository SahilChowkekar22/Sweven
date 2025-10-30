//
//  Product.swift
//  Sweven
//
//  Created by Sahil ChowKekar on 10/30/25.
//

import Foundation

struct Product: Identifiable{
    var id = UUID()
    var name: String
    var image: String
    var price: Int
}

var productList = [Product(name: "Caramel Stripe Bliss", image: "1", price: 47),
                   Product(name: "Nordic Ivory Turtleneck", image: "2", price: 55),
                   Product(name: "Ocean Breeze Stripe", image: "3", price: 61),
                   Product(name: "Pink Blaze Knit ", image: "4", price: 59),
                   Product(name: "Moss Trail Cable Knit", image: "5", price: 63),
                   Product(name: "Midnight Harbor Turtleneck", image: "6", price: 53),
                   Product(name: "Sandstone Classic Turtleneck", image: "7", price: 65),
                   Product(name: "Pumpkin Puff", image: "8", price: 85)]
