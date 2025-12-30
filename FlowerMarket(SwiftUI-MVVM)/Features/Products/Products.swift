//
//  Flowers.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import Foundation

struct Products: Identifiable, Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: String
}

struct ProductsResponse: Decodable {
    let products: [Products]
}



//{
//    "page":1,
//    "per_page":15,
//    "photos":
//    [{"id":56866,
//        "width":3008,
//        "height":2000,
//        "url":"https://www.pexels.com/photo/close-photography-of-red-and-pink-rose-56866/",
//        "photographer":"Pixabay",
//        "photographer_url":"https://www.pexels.com/@pixabay",
//        "photographer_id":2659,
//        "avg_color":"#533328",
//        "src":{
//            "original":"https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg",
//            "large2x":"https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg?auto=compress\u0026cs=tinysrgb\u0026dpr=2\u0026h=650\u0026w=940",
//            "large":"https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg?auto=compress\u0026cs=tinysrgb\u0026h=650\u0026w=940",
//            "medium":"https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg?auto=compress\u0026cs=tinysrgb\u0026h=350",
//            "small":"https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg?auto=compress\u0026cs=tinysrgb\u0026h=130",
//            "portrait":"https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg?auto=compress\u0026cs=tinysrgb\u0026fit=crop\u0026h=1200\u0026w=800",
//            "landscape":"https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg?auto=compress\u0026cs=tinysrgb\u0026fit=crop\u0026h=627\u0026w=1200",
//            "tiny":"https://images.pexels.com/photos/56866/garden-rose-red-pink-5686.jpeg?auto=compress\u0026cs=tinysrgb\u0026dpr=1\u0026fit=crop\u0026h=200\u0026w=280"
//        },
//        "liked":false,
//        "alt":"Vibrant red rose with fresh dewdrops, captured in a blooming garden setting."
//    }
