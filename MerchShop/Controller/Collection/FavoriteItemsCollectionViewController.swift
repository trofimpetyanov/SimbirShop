//
//  FavoriteItemsCollectionViewController.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 17.02.2022.
//

import UIKit

class FavoriteItemsCollectionViewController: UICollectionViewController {
    typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.SectionItem>
    
    //MARK: – View Model
    struct ViewModel {
        enum Section {
            case favoriteItems
        }
        
        typealias SectionItem = CatalogItem
    }
    
    //MARK: – Model
    struct Model {
        var favoriteItems: [CatalogItem] {
            Settings.shared.favoriteItems
        }
    }
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollectionView), name: NSNotification.Name("favoriteItemsNeedUpdate"), object: nil)
    }
    
    //MARK: – Update
    @objc private func updateCollectionView() {
        updateSnapshot()
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ViewModel.Section, ViewModel.SectionItem>()
        
        let items = model.favoriteItems
        
        snapshot.appendSections([.favoriteItems])
        snapshot.appendItems(items, toSection: .favoriteItems)
        
        dataSource.apply(snapshot)
    }
    
    //MARK: – Actions
    @IBSegueAction func showDetailItem(_ coder: NSCoder, sender: Any?) -> ItemDetailViewController? {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first, let selectedItem = dataSource.itemIdentifier(for: selectedIndexPath) else { return nil }
        
        return ItemDetailViewController(coder: coder, item: selectedItem)
    }
    
    @IBAction func clearFavoritesButtonTapped(_ sender: UIBarButtonItem) {
        Settings.shared.favoriteItems = []
        updateCollectionView()
    }
    
    //MARK: – Collection View Setup
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { elements in
            guard self.dataSource.itemIdentifier(for: indexPath) != nil else { return nil }
            
            let deleteItem = UIAction(title: "Удалить", image: .remove) { (action) in
                Settings.shared.favoriteItems.remove(at: indexPath.row)
                self.updateCollectionView()
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [deleteItem])
        }
        
        return config
    }
    
    //MARK: – Data Source
    private func createDataSource() -> DataSourceType {
        DataSourceType(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteItemCollectionViewCell.reuseIdentifier, for: indexPath) as! FavoriteItemCollectionViewCell
            
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
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(330))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
            section.interGroupSpacing = spacing
            
            return section
        }
        
        return layout
    }
}
