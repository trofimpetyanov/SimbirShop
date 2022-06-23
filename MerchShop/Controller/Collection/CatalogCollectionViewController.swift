//
//  CatalogCollectionViewController.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 16.02.2022.
//

import UIKit

class CatalogCollectionViewController: UICollectionViewController {
    typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>
    
    //MARK: – View Model
    struct ViewModel {
        enum Section {
            case collections
            case categories
        }
        
        enum Item: Hashable {
            case collection(_ collection: Collection)
            case category(_ category: Category)
        }
    }
    
    enum SupplementaryViewKind {
        static let header = "header"
    }
    
    //MARK: – Model
    struct Model {
        var categories: [Category] {
            Settings.shared.categories
        }
        
        var collections: [Collection] {
            Settings.shared.collections
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
        
        let categories = model.categories
        let categoryItems = categories.map { ViewModel.Item.category($0) }
        
        let collections = model.collections
        let collectionItems = collections.map { ViewModel.Item.collection($0) }
        
        snapshot.appendSections([.categories, .collections])
        snapshot.appendItems(categoryItems, toSection: .categories)
        snapshot.appendItems(collectionItems, toSection: .collections)
        
        dataSource.apply(snapshot)
    }
    
    //MARK: – Actions
    @IBSegueAction func showCollectionCategory(_ coder: NSCoder, sender: Any?) -> CollectionCategoryCollectionViewController? {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first, let item = dataSource.itemIdentifier(for: selectedIndexPath) else { return nil }
        
        switch item {
        case .category(let category):
            return CollectionCategoryCollectionViewController(coder: coder, category: category)
        case .collection(let collection):
            return CollectionCategoryCollectionViewController(coder: coder, collection: collection)
        }
    }
    
    //MARK: – Data Source
    private func createDataSource() -> DataSourceType {
        let dataSource = DataSourceType(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCollectionViewCell.reuseIdentifier, for: indexPath) as! CatalogCollectionViewCell
            
            switch itemIdentifier {
            case .category(let category):
                cell.configure(with: category)
            case .collection(let collection):
                cell.configure(with: collection)
            }
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            switch kind {
            case SupplementaryViewKind.header:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                
                switch section {
                case .categories:
                    break
                case .collections:
                    headerView.setTitle("Коллекции")
                }
                
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
        let spacing: CGFloat = 8
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: SupplementaryViewKind.header, alignment: .top)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
            section.interGroupSpacing = spacing
            
            switch self.dataSource.snapshot().sectionIdentifiers[sectionIndex] {
            case .categories:
                break
            case .collections:
                section.boundarySupplementaryItems = [headerItem]
            }
            
            return section
        }
        
        return layout
    }
}
