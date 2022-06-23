//
//  SimbirsoftCollectionViewController.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 15.02.2022.
//

import UIKit

class SimbirsoftCollectionViewController: UICollectionViewController {
    typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>
    
    //MARK: – View Model
    enum ViewModel {
        enum Section {
            case lastAdded
            case hotPicks
            case onSale
        }
        
        typealias Item = CatalogItem
    }
    
    enum SupplementaryViewKind {
        static let header = "header"
    }
    
    //MARK: – Model
    struct Model {
        var categories: [Category] {
            Settings.shared.categories
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
        
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
    }
    
    //MARK: – Update
    private func updateCollectionView() {
        updateSnapshot()
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ViewModel.Section, ViewModel.Item>()
        
        let allItems = model.categories.reduce([CatalogItem]()) { partialResult, category in
            partialResult + category.items
        }
        let lastAddedItems = allItems.filter { $0.isNew }
        let hotPickItems = allItems.filter { $0.isHotPick }
        let onSaleItems = allItems.filter { $0.discount != nil }
        
        snapshot.appendSections([.lastAdded, .hotPicks, .onSale])
        snapshot.appendItems(lastAddedItems, toSection: .lastAdded)
        snapshot.appendItems(hotPickItems, toSection: .hotPicks)
        snapshot.appendItems(onSaleItems, toSection: .onSale)
        
        dataSource.apply(snapshot)
    }
    
    //MARK: – Actions
    @IBSegueAction func showItemDetail(_ coder: NSCoder, sender: Any?) -> ItemDetailViewController? {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first, let selectedItem = dataSource.itemIdentifier(for: selectedIndexPath) else { return nil }
        
        return ItemDetailViewController(coder: coder, item: selectedItem)
    }
    
    //MARK: – Data Source
    private func createDataSource() -> DataSourceType {
        let dataSource = DataSourceType(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
            
            cell.configure(with: itemIdentifier)
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            switch kind {
            case SupplementaryViewKind.header:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
                
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                
                let sectionName: String
                
                switch section {
                case .lastAdded:
                    sectionName = "Новинки"
                case .hotPicks:
                    sectionName = "Популярное"
                case .onSale:
                    sectionName = "Распродажа"
                }
                
                headerView.setTitle(sectionName)
                
                return headerView
            default:
                return nil
            }
        }
        
        return dataSource
    }
    
    //MARK: – Layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let padding: CGFloat = 16
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: SupplementaryViewKind.header, alignment: .top)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .absolute(230))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            group.interItemSpacing = .fixed(padding)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
            section.interGroupSpacing = padding
            section.orthogonalScrollingBehavior = .continuous
            
            section.boundarySupplementaryItems = [headerItem]
            
            return section
        }
        
        return layout
    }
    
}
