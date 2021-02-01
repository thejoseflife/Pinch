//
//  Models.swift
//  Pinch
//
//  Created by Josef Sajonz on 1/4/21.
//  Copyright © 2021 Josef Sajonz. All rights reserved.
//

struct Item: Codable {
    
    let price: Float
    let title: String
    let recurring: Int
    let interval: Int
    let creationDate: Double
    
    init(title: String, price: Float, recurring: Int, interval: Int, creationDate: Double) {
        self.price = price
        self.title = title
        self.recurring = recurring
        self.interval = interval
        self.creationDate = creationDate
    }
    
}
