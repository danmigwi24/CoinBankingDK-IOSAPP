# **Custom UICollectionViewCell Implementation**

This project demonstrates how to create a custom `UICollectionViewCell` in Swift using UIKit. It includes:
- A **custom cell** with a rounded blue background and centered text.
- A **UICollectionView** with a flow layout.
- Proper **data source and delegate** setup.
- **Auto Layout constraints** for dynamic sizing.

## **Features**
✅ Custom `UICollectionViewCell` with programmatic UI  
✅ Dynamic cell registration and dequeuing  
✅ UICollectionViewFlowLayout configuration (item size, spacing)  
✅ Selection handling via `UICollectionViewDelegate`  
✅ Auto Layout constraints for responsive design  

---

## **Code Structure**
### **1. `CustomCollectionViewCell.swift`**
- Subclasses `UICollectionViewCell`.
- Contains a `UILabel` for displaying text.
- Uses Auto Layout for positioning.
- Provides a `configure(with:)` method to update cell content.

### **2. `UiCollectionViewController.swift`**
- Sets up a `UICollectionView` with a `UICollectionViewFlowLayout`.
- Registers and dequeues the custom cell.
- Implements `UICollectionViewDataSource` and `UICollectionViewDelegate`.
- Includes sample data for demonstration.

---

## **How It Works**
1. **Custom Cell Setup**  
   - The cell has a blue background, rounded corners, and a white bold label.
   - Constraints ensure the label stays centered.

2. **UICollectionView Configuration**  
   - Uses `UICollectionViewFlowLayout` with:
     - `itemSize = CGSize(width: 120, height: 120)`
     - `minimumLineSpacing = 10`
     - `minimumInteritemSpacing = 10`
   - Registers the custom cell with `register(_:forCellWithReuseIdentifier:)`.

3. **Data Population**  
   - The `UICollectionViewDataSource` provides:
     - Number of items (`items.count`).
     - Cell configuration via `dequeueReusableCell`.

4. **Cell Selection Handling**  
   - The `UICollectionViewDelegate` prints the selected item when tapped.

---

## **Usage**
1. **Integrate into Your Project**  
   - Copy `CustomCollectionViewCell.swift` and `UiCollectionViewController.swift` into your project.
   - Replace sample data (`items` array) with your own.

2. **Customization**  
   - Modify `CustomCollectionViewCell` to include images, different styling, or additional UI elements.
   - Adjust `UICollectionViewFlowLayout` for different grid styles.

3. **Run the App**  
   - Displays a grid of blue rounded cells with sample text.
   - Tapping a cell logs its text to the console.

---

## **Dependencies**
- **UIKit** (No external libraries needed)

---

## **Screenshots (Expected Output)**
| Light Mode | Dark Mode |
|------------|------------|
| ![Light Mode](https://via.placeholder.com/300x500/FFFFFF/000000?text=Light+Mode+Demo) | ![Dark Mode](https://via.placeholder.com/300x500/000000/FFFFFF?text=Dark+Mode+Demo) |

---

## **Possible Enhancements**
- **Dynamic Cell Sizing**: Use `UICollectionViewDelegateFlowLayout` for variable cell sizes.
- **Networking**: Load data from an API instead of a local array.
- **Diffable Data Source**: Use `UICollectionViewDiffableDataSource` (iOS 13+) for better performance.
- **SwiftUI Integration**: Wrap the `UICollectionView` in a `UIViewControllerRepresentable`.

---

## **License**
This project is available under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## **Author**
👤 **[Your Name]**  
📧 [your.email@example.com](mailto:your.email@example.com)  
🔗 [GitHub](https://github.com/yourusername) | [Twitter](https://twitter.com/yourhandle)  

---

🚀 **Happy Coding!** Let me know if you need further improvements.
