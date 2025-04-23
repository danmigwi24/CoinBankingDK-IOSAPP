//
//  UiSimpleTableViewController.swift
//  CoinBankingDK
//
//  Created by Daniel Kimani on 24/04/2025.
//
import UIKit
import SwiftUI

struct UiSimpleTableViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UiSimpleTableViewController {
        let vc = UiSimpleTableViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UiSimpleTableViewController, context: Context) {
        
    }
}

class UiSimpleTableViewController: UIViewController {
    
    private var items = sampleItems//["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10"]
    
    // Lazy-initialized UITableView
    lazy var tableViewColle: UITableView = {
        let view = UITableView()
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomSimpleTableViewCell")
        view.rowHeight = 80 // Set default row height
        view.separatorStyle = .none // Remove default separators
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableViewColle)
        
        NSLayoutConstraint.activate([
            tableViewColle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewColle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewColle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewColle.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension UiSimpleTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CustomSimpleTableViewCell",
            for: indexPath
        ) as? CustomSimpleTableViewCell else {
            return UITableViewCell()
        }
        
        //cell.configureItemModel(item: items[indexPath.row])
        cell.configureString(text: items[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(items[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Optional: Set custom height for specific rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

/*
// MARK: - UITableViewDelegate
extension UiTableViewController {
    // Enable swipe actions
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: nil) { [weak self] (_, _, completionHandler) in
            self?.toggleFavorite(at: indexPath)
            completionHandler(true)
        }
        
        // Set favorite action icon and color
        favoriteAction.image = UIImage(systemName: "star.fill")
        favoriteAction.backgroundColor = .systemYellow
        
        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return configuration
    }
    
    private func toggleFavorite1(at indexPath: IndexPath) {
        let item = items[indexPath.row]
        print("Toggled favorite for: \(item)")
        
        // Here you would typically:
        // 1. Update your data model to mark the item as favorite
        // 2. Reload the row to reflect the change
        // 3. Or show some visual feedback
        
        // For now, we'll just show a temporary visual feedback
        if let cell = tableViewColle.cellForRow(at: indexPath) as? CustomTableViewCell {
            cell.showFavoriteAnimation()
        }
    }
    
    private func toggleFavorite(at indexPath: IndexPath) {
        // Toggle favorite status
        items[indexPath.row].isFavorite.toggle()
        
        // Get the current item
        let item = items[indexPath.row]
        
        // Provide haptic feedback
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.success)
        
        // Update the cell if visible
        if let cell = tableViewColle.cellForRow(at: indexPath) as? CustomTableViewCell {
            cell.updateFavoriteStatus(item.isFavorite)
        }
        
        // Optional: Reload the row to ensure UI consistency
        // tableViewColle.reloadRows(at: [indexPath], with: .none)
        
        print("\(item.title) is now \(item.isFavorite ? "favorited" : "unfavorited")")
    }
}
*/




final class CustomSimpleTableViewCell: UITableViewCell {
    //
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let favoriteIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .systemYellow
        view.alpha = 0  // Start hidden
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear // Make cell background clear
        contentView.backgroundColor = .clear
        
        // Configure container
        containerView.backgroundColor = .systemBlue
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(favoriteIcon)
        
        NSLayoutConstraint.activate([
            // Container with top padding
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Label inside container
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            
            // Favorite icon constraints
            favoriteIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            favoriteIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 20),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Configure Cell
    func configureString(text: String) {
        titleLabel.text = text
    }
    

}

/*
extension CustomTableViewCell{
    
    func configureItemModel(item: ItemModel) {
        titleLabel.text = item.title
        updateFavoriteStatus(item.isFavorite)
    }
    
    func showFavoriteAnimation() {
        // Create a temporary star image view for animation
        let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
        starImageView.tintColor = .systemYellow
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add to container
        containerView.addSubview(starImageView)
        
        // Position constraints
        NSLayoutConstraint.activate([
            starImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            starImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 40),
            starImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Animate
        starImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            starImageView.transform = .identity
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 0.5, options: [], animations: {
                starImageView.alpha = 0
            }, completion: { _ in
                starImageView.removeFromSuperview()
            })
        }
    }
    
    func updateFavoriteStatus(_ isFavorite: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.favoriteIcon.alpha = isFavorite ? 1 : 0
        }
        
        // Optional: Add a bounce animation when favoriting
        if isFavorite {
            favoriteIcon.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: [],
                           animations: {
                self.favoriteIcon.transform = .identity
            })
        }
    }
}
*/
