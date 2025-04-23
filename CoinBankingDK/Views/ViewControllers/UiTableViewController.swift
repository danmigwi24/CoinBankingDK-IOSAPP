//
//  UiTableViewController.swift
//  CoinBankingDK
//
//  Created by Daniel Kimani on 24/04/2025.
//
//
import UIKit
import SwiftUI

struct UiTableViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UiTableViewController {
        let vc = UiTableViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UiTableViewController, context: Context) {
        
    }
}

class UiTableViewController: UIViewController {
    
    private var items: [ItemModel] = sampleItems
    private var filteredItems: [ItemModel] = []
    private var currentCategory: AnimalCategory? = nil
    
    // Add a segmented control for filtering
    private lazy var categorySegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["All"] + AnimalCategory.allCases.map { $0.rawValue.capitalized })
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(categoryChanged(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    lazy var tableViewColle: UITableView = {
        let view = UITableView()
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 80
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyFilter() // Initialize with all items
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add the segmented control
        view.addSubview(categorySegmentedControl)
        view.addSubview(tableViewColle)
        
        NSLayoutConstraint.activate([
            categorySegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            categorySegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categorySegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableViewColle.topAnchor.constraint(equalTo: categorySegmentedControl.bottomAnchor, constant: 8),
            tableViewColle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewColle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewColle.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func categoryChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            currentCategory = nil // Show all
        } else {
            let selectedCategory = AnimalCategory.allCases[sender.selectedSegmentIndex - 1]
            currentCategory = selectedCategory
        }
        applyFilter()
    }
    
    private func applyFilter() {
        if let category = currentCategory {
            filteredItems = items.filter { $0.category == category }
        } else {
            filteredItems = items
        }
        tableViewColle.reloadData()
    }
    
    private func toggleFavorite(at indexPath: IndexPath) {
        let itemId = filteredItems[indexPath.row].id
        if let index = items.firstIndex(where: { $0.id == itemId }) {
            items[index].isFavorite.toggle()
            applyFilter() // Reapply filter to update the displayed items
        }
    }
}

extension UiTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CustomTableViewCell",
            for: indexPath
        ) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: filteredItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: nil) { [weak self] (_, _, completionHandler) in
            self?.toggleFavorite(at: indexPath)
            completionHandler(true)
        }
        
        let isFavorite = filteredItems[indexPath.row].isFavorite
        favoriteAction.image = UIImage(systemName: isFavorite ? "star.slash.fill" : "star.fill")
        favoriteAction.backgroundColor = isFavorite ? .systemRed : .systemYellow
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



final class CustomTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.8)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(itemImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(countLabel)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(favoriteIcon)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            itemImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            itemImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 40),
            itemImageView.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteIcon.leadingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            countLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            categoryLabel.centerYAnchor.constraint(equalTo: countLabel.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: titleLabel.trailingAnchor),
            
            favoriteIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            favoriteIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 20),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(with item: ItemModel) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        countLabel.text = "Count: \(item.count)"
        categoryLabel.text = "Category: \(item.category.rawValue.capitalized)"
        itemImageView.image = UIImage(systemName: item.imageName)
        
        updateFavoriteStatus(item.isFavorite)
    }
    
    func updateFavoriteStatus(_ isFavorite: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.favoriteIcon.alpha = isFavorite ? 1 : 0
        }
    }
}
