//
//  MyViewController.swift
//  CoinBankingDK
//
//  Created by Daniel Kimani on 23/04/2025.
//

import UIKit
import SwiftUI

class MyViewController: UIViewController {
    lazy var label: UILabel = {
           let label = UILabel()
           label.textColor = .white
           label.text = "Initial Text"
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }

    func updateLabel(text: String) {
        label.text = text
    }
}



struct MyViewControllerRepresentable: UIViewControllerRepresentable {
    var title: String

    func makeUIViewController(context: Context) -> MyViewController {
        let vc = MyViewController()
        vc.updateLabel(text: title)
        return vc
    }

    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {
        // This gets called when `title` changes in SwiftUI
        uiViewController.updateLabel(text: title)
    }
}
