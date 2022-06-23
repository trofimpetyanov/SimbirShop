//
//  CollectionCategoryCollectionViewController.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 16.02.2022.
//

import UIKit

class CollectionCategoryCollectionViewController: UICollectionViewController {
    typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.SectionItem>
    
    //MARK: – ViewModel
    enum ViewModel {
        enum Section {
            case description
            case categoryItems
            case collectionItems
        }
        
        enum SectionItem: Hashable {
            case description(_ description: String)
            case item(_ item: CatalogItem)
        }
    }
    
    enum SupplementaryViewKind {
        static let header = "header"
    }
    
    //MARK: – Init
    init?(coder: NSCoder, category: Category) {
        self.category = category
        super.init(coder: coder)
    }
    
    init?(coder: NSCoder, collection: Collection) {
        self.collection = collection
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: – Properties
    var category: Category?
    var collection: Collection?
    
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
        
        if let category = category {
            title = category.name
        } else if let collection = collection {
            title = collection.name
        }
    }
    
    //MARK: – Updates
    private func updateCollectionView() {
        updateSnapshot()
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ViewModel.Section, ViewModel.SectionItem>()
        
        if let category = category {
            let items = category.items.map { ViewModel.SectionItem.item($0) }
            
            snapshot.appendSections([.categoryItems])
            snapshot.appendItems(items, toSection: .categoryItems)
        } else if let collection = collection {
            let description = ViewModel.SectionItem.description(collection.description)
            let items = collection.items.map { ViewModel.SectionItem.item($0) }
            
            snapshot.appendSections([.description, .collectionItems])
            snapshot.appendItems([description], toSection: .description)
            snapshot.appendItems(items, toSection: .collectionItems)
        }
        
        dataSource.apply(snapshot)
    }

    //MARK: – Actions
    @IBSegueAction func showDetailItem(_ coder: NSCoder, sender: Any?) -> ItemDetailViewController? {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first, let selectedItem = dataSource.itemIdentifier(for: selectedIndexPath) else { return nil }

        switch selectedItem {
        case .item(let item):
            return ItemDetailViewController(coder: coder, item: item)
        case .description(_):
            return nil
        }
    }
    
    
    //MARK: – Data Source
    private func createDataSource() -> DataSourceType {
        DataSourceType(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .description(let description):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCollectionViewCell.reuseIdentifier, for: indexPath) as! TextCollectionViewCell
                
                cell.configure(with: description)
                
                return cell
            case .item(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
                
                cell.configure(with: item)
                
                return cell
            }
        }
    }
    
    //MARK: – Layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let padding: CGFloat = 16
            
            switch self.dataSource.snapshot().sectionIdentifiers[sectionIndex] {
            case .description:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(160))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(160))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: 0, trailing: padding)
                
                return section
            case .categoryItems, .collectionItems:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(288))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(288))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                group.interItemSpacing = .fixed(padding)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
                section.interGroupSpacing = padding
                
                return section
            }
        }
    }
}
