//
//  ItemDetailViewController.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 16.02.2022.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    init?(coder: NSCoder, item: CatalogItem) {
        self.item = item
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: – Outlets
    @IBOutlet var favoriteButton: UIBarButtonItem!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var detailView: UIView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var nonDiscountPriceLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var chooseSizeButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var addToCartButton: UIButton!
    
    //MARK: – Properties
    var item: CatalogItem?
    
    let numberFormatter = Settings.shared.numberFormatter
    
    //MARK: – Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    //MARK: – Helpers
    private func setup() {
        setupUI()
        
        guard let item = item else { return }

        if let image = UIImage(named: item.imageName) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "photo")
        }
        
        if let discount = item.discount {
            nonDiscountPriceLabel.isHidden = false
            
            let discountPrice = item.price * (1 - discount / 100)
            
            nonDiscountPriceLabel.text = numberFormatter.string(from: NSNumber(value: item.price))
            priceLabel.text = numberFormatter.string(from: NSNumber(value: discountPrice))
        } else {
            nonDiscountPriceLabel.isHidden = true
            
            priceLabel.text = numberFormatter.string(from: NSNumber(value: item.price))
        }
        
        if Settings.shared.favoriteItems.contains(item) {
            favoriteButton.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteButton.image = UIImage(systemName: "heart")
        }
        
        nameLabel.text = item.name
        descriptionLabel.text = item.description
    }
    
    private func setupUI() {
        detailView.layer.cornerRadius = 32
        detailView.layer.shadowColor = UIColor.black.cgColor
        detailView.layer.shadowOffset = CGSize(width: 0, height: 0)
        detailView.layer.shadowRadius = 6.0
        detailView.layer.shadowOpacity = 0.1
        detailView.layer.masksToBounds = false
        detailView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(origin: detailView.bounds.origin, size: CGSize(width: detailView.bounds.size.width, height: detailView.bounds.size.height - 200)), cornerRadius: detailView.layer.cornerRadius).cgPath
        
        imageView.layer.cornerRadius = 16
        chooseSizeButton.layer.cornerRadius = 8
        
        addToCartButton.layer.cornerRadius = 8
    }
    
    //MARK: – Actions
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let item = item else { return }
        
        if Settings.shared.favoriteItems.contains(item), let firstIndex = Settings.shared.favoriteItems.firstIndex(of: item) {
            var favoriteItems = Settings.shared.favoriteItems
            
            favoriteItems.remove(at: firstIndex)
            
            Settings.shared.favoriteItems = favoriteItems
            favoriteButton.image = UIImage(systemName: "heart")
        } else {
            var favoriteItems = Settings.shared.favoriteItems
            
            favoriteItems.insert(item, at: 0)
            
            Settings.shared.favoriteItems = favoriteItems
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        guard let item = item else { return }
        
        let cartItem = CartItem(item: item)
        
        if !Settings.shared.cartItems.contains(cartItem) {
            Settings.shared.cartItems.append(cartItem)
            
            addToCartButton.setTitle("Добавлено в", for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.addToCartButton.setTitle("Добавить", for: .normal)
            }
        } else {
            let alert = UIAlertController(title: "Товар уже в корзине", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
    }
}
