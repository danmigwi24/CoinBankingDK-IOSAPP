//
//  UiCollectionViewController.swift
//  CoinBankingDK
//
//  Created by Daniel Kimani on 24/04/2025.
//
import UIKit
import SwiftUI



struct UiCollectionViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UiCollectionViewController {
        let vc = UiCollectionViewController()
        return vc
    }

    func updateUIViewController(_ uiViewController: UiCollectionViewController, context: Context) {
        
    }
}



class UiCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    //let cats: [String] = ["🐱", "🐱‍🐉", "🐈"]
    private let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
    lazy var collectionView: UICollectionView = {
        //
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setupUI()
        //
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
        
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBlue
        view.addSubview(collectionView)
        // Either use this syntax:
        /*
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        */
        // OR this syntax (but not both):
        ///*
         collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
         collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
         //*/
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CustomCollectionViewCell",
            for: indexPath
        ) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: items[indexPath.row])
        //cell.titleLabel.text = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(items[indexPath.row])")
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: view.frame.width/2 - 20, height: 250)
    }
    
}



final class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
     let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .systemBlue
        layer.cornerRadius = 1
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ])
        
        /*
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
         */
    }
    
    // MARK: - Configure Cell
    func configure(with text: String) {
        titleLabel.text = text
    }
    
    // MARK: - Configure Cell
    func configureWithItemModel(model: ItemModel) {
        titleLabel.text = model.title
    }
}

