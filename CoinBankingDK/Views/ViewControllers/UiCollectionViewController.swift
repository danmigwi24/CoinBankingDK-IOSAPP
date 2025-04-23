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



class UiCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    //let cats: [String] = ["🐱", "🐱‍🐉", "🐈"]
    private let items = sampleItems//["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
    // MARK: - UI Components
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10    // Vertical spacing between rows
        layout.minimumInteritemSpacing = 10   // Horizontal spacing between cells
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setupUI()
        //
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        //
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //
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
        
        cell.configure(with: items[indexPath.row].title)
        //cell.titleLabel.text = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(items[indexPath.row])")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate available width (subtracting left/right insets and interitem spacing)
        let totalHorizontalSpacing: CGFloat = 16 * 2 + 10   // leading+trailing insets + interitem spacing
        let availableWidth = collectionView.bounds.width - totalHorizontalSpacing
        let cellWidth = availableWidth / 2   // Divide by number of columns (2)
        
        // return CGSize(width: cellWidth, height: 120)  // Fixed height (adjust as needed)
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



