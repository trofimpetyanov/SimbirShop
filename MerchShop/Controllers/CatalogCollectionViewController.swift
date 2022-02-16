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
    
    //MARK: – Model
    struct Model {
        var collections: [Collection] {
            Settings.shared.collections
        }
        
        var categories: [Category] {
            Settings.shared.categories
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
    }
    
    //MARK: – Update
    private func updateCollectionView() {
        updateSnapshot()
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ViewModel.Section, ViewModel.Item>()
        
        let categories = model.categories
        let categoryItems = categories.map { ViewModel.Item.category($0) }
        
        snapshot.appendSections([.categories])
        snapshot.appendItems(categoryItems, toSection: .categories)
        
        dataSource.apply(snapshot)
    }
    
    //MARK: – Data Source
    private func createDataSource() -> DataSourceType {
        DataSourceType(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catalogCell", for: indexPath) as! CatalogCollectionViewCell
            
            switch itemIdentifier {
            case .collection(_):
                break
            case .category(let category):
                cell.configure(with: category)
            }
            
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
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
            section.interGroupSpacing = spacing
            
            return section
        }
        
        return layout
    }
}
