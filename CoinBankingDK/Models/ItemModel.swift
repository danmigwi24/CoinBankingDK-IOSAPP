//
//  ItemModel.swift
//  CoinBankingDK
//
//  Created by Daniel Kimani on 24/04/2025.
//

import Foundation

struct ItemModel: Identifiable {
    let id: UUID = UUID()
    var title: String
    var description: String
    var count: Int
    var imageName: String
    var isFavorite: Bool
}


let sampleItems: [ItemModel] = [
    ItemModel(
        title: "Learn SwiftUI",
        description: "Master Apple’s modern UI framework for building iOS apps.",
        count: 12,
        imageName: "book.fill",
        isFavorite: true
    ),
    ItemModel(
        title: "Explore UIKit",
        description: "Dive into the fundamentals of UIKit and its components.",
        count: 8,
        imageName: "square.stack.fill",
        isFavorite: false
    ),
    ItemModel(
        title: "Understand Combine",
        description: "Reactive programming for modern Swift apps.",
        count: 5,
        imageName: "arrow.triangle.2.circlepath",
        isFavorite: false
    ),
    ItemModel(
        title: "Swift Algorithms",
        description: "Sharpen your problem-solving skills with real challenges.",
        count: 20,
        imageName: "brain.head.profile",
        isFavorite: true
    ),
    ItemModel(
        title: "iOS Animations",
        description: "Bring your UI to life with smooth animations.",
        count: 7,
        imageName: "sparkles",
        isFavorite: false
    )
]
