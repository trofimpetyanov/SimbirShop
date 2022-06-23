//
//  OrderTableViewController.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 18.02.2022.
//

import UIKit

class OrderTableViewController: UITableViewController {
    //MARK: – Init
    init?(coder: NSCoder, order: Order) {
        self.order = order
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: – Outlets
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet var nonDiscountPriceLabel: UILabel!
    @IBOutlet var deliveryCostLabel: UILabel!
    @IBOutlet var discountLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    //MARK: – Properties
    let order: Order?
    let numberFormatter = Settings.shared.numberFormatter
    
    var deliveryPrice = 500
    
    //MARK: – Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    //MARK: – Helpers
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: – Setup
    private func setup() {
        guard let order = order else { return }
        
        nonDiscountPriceLabel.text = numberFormatter.string(from: NSNumber(value: order.totalWithoutDiscount))
        discountLabel.text = numberFormatter.string(from: NSNumber(value: order.totalWithoutDiscount - order.totalWithDiscount))
        totalLabel.text = numberFormatter.string(from: NSNumber(value: order.totalWithDiscount + Double(deliveryPrice)))

        //        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //
        //        view.addGestureRecognizer(tap)
    }
    
    //MARK: – Actions
    @IBAction func payButtonTapped(_ sender: UIButton) {
        var isFilled = true
        textFields.forEach { textField in
            if let text = textField.text, text.isEmpty {
                isFilled = false
            }
        }
        
        let alert = UIAlertController(title: isFilled ? "Cпасибо за заказ!" : "Внимание!", message: isFilled ? "Оплата проведена успешно" : "Адрес заполнен некорректно" , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { (action) in
            if isFilled {
                NotificationCenter.default.post(name: Notification.Name("clearCart"), object: nil)
            }
            
            self.performSegue(withIdentifier: "unwindToCartCollectionViewController", sender: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: – Table View Configuration
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 1 else { return }
        
        //делал в 5 утра, пожалуйста не судите строго :(
        if indexPath.row == 0 {
            let selectedCell = tableView.cellForRow(at: indexPath)
            let nextCell = tableView.cellForRow(at: IndexPath(row: 1, section: 1))
            
            if selectedCell?.accessoryType == UITableViewCell.AccessoryType.none {
                selectedCell?.accessoryType = .checkmark
                nextCell?.accessoryType = .none
                deliveryCostLabel.text = numberFormatter.string(from: NSNumber(500))
                deliveryPrice = 500
            }
        } else {
            let selectedCell = tableView.cellForRow(at: indexPath)
            let previousCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1))
            
            if selectedCell?.accessoryType == UITableViewCell.AccessoryType.none {
                selectedCell?.accessoryType = .checkmark
                previousCell?.accessoryType = .none
                deliveryCostLabel.text = numberFormatter.string(from: NSNumber(2000))
                deliveryPrice = 2000
            }
        }
        
        setup()
    }
}
