//
//  CartCollectionViewController.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 17.02.2022.
//

import UIKit

class CartCollectionViewController: UICollectionViewController {
    typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>
    
    //MARK: – View Model
    struct ViewModel {
        enum Section {
            case cartItems
        }
        
        typealias Item = CartItem
    }
    
    //MARK: – Model
    struct Model {
        var cartItems: [CartItem] {
            Settings.shared.cartItems
        }
    }
    
    //MARK: – Properties
    let model = Model()
    var dataSource: DataSourceType!
    
    //MARK: – Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateCollectionView()
    }
    
    //MARK: – Helpers
    private func setup() {
        dataSource = createDataSource()
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = createLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearCart), name: Notification.Name("clearCart"), object: nil)
    }
    
    @objc func clearCart() {
        Settings.shared.cartItems = []
        updateCollectionView()
    }
    
    //MARK: – Update
    private func updateCollectionView() {
        updateSnapshot()
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ViewModel.Section, ViewModel.Item>()
        let items = model.cartItems
        
        snapshot.appendSections([.cartItems])
        snapshot.appendItems(items, toSection: .cartItems)
        
        dataSource.apply(snapshot)
    }
    
    //MARK: – Actions
    @IBAction func showOrder(_ sender: UIBarButtonItem) {
        guard model.cartItems.count > 0 else {
            let alert = UIAlertController(title: "Невозможно оформить заказ", message: "В корзине отсутсвуют товары", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        var isAllItemsWithSize = true
        
        model.cartItems.forEach { cartItem in
            if cartItem.size == nil {
                isAllItemsWithSize = false
            }
        }
        
        if isAllItemsWithSize {
            performSegue(withIdentifier: "orderSegue", sender: nil)
        } else {
            let alert = UIAlertController(title: "Невозможно оформить заказ", message: "У некоторых товаров не выбран размер", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
            return
        }
    }
    
    @IBAction func clearCartButtonTapped(_ sender: UIBarButtonItem) {
        clearCart()
    }
    @IBSegueAction func showItemDetail(_ coder: NSCoder, sender: Any?) -> ItemDetailViewController? {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first, let selectedItem = dataSource.itemIdentifier(for: selectedIndexPath) else { return nil }
        
        return ItemDetailViewController(coder: coder, item: selectedItem.item)
    }
    
    @IBSegueAction func showOrder(_ coder: NSCoder, sender: Any?) -> OrderTableViewController? {
        let items = model.cartItems
        let totalWithoutDiscount = model.cartItems.reduce(0) { $0 + $1.item.price * Double($1.amount) }
        let totalWithDiscount = model.cartItems.reduce(0) { $0 + $1.item.discountPrice * Double($1.amount) }
        let order = Order(items: items, totalWithoutDiscount: totalWithoutDiscount, delivery: nil, totalWithDiscount: totalWithDiscount)
        
        return OrderTableViewController(coder: coder, order: order)
    }
    
    //MARK: – Collection View Setup
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { elements in
            guard self.dataSource.itemIdentifier(for: indexPath) != nil else { return nil }
            
            let deleteItem = UIAction(title: "Удалить", image: .remove) { (action) in
                Settings.shared.cartItems.remove(at: indexPath.row)
                self.updateCollectionView()
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [deleteItem])
        }
        
        return config
    }
    
    //MARK: – Data Source
    private func createDataSource() -> DataSourceType {
        DataSourceType(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartItemCollectionViewCell.reuseIdentifier, for: indexPath) as! CartItemCollectionViewCell
            
            cell.configure(with: itemIdentifier)
            
            return cell
        }
    }
    
    //MARK: – Layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let padding: CGFloat = 16
        let spacing: CGFloat = 8
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
            section.interGroupSpacing = spacing
            
            return section
        }
        
        return layout
    }
    
    @IBAction func unwindToCartCollectionViewController(segue: UIStoryboardSegue) {
        
    }
}
