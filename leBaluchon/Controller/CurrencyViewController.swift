//
//  CurrencyViewController.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 05/09/2021.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    // MARK: - Properties
    var currencyCode: [String] = []
    var values: [Double] = []
    var activeCurrency = 0.0
    
    // MARK: - IBOutlets
    @IBOutlet var textField: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        CurrencyService.shared.fetchJSON {(currrencyData) in
            let currencyData = currrencyData
            self.useData(currencyData: currencyData!)
        }
        textField.addTarget(self, action: #selector(updateViews), for: .editingChanged)
    }
    
    @objc func updateViews(input: Double) {
        guard let amountText = textField.text, let theAmountText = Double(amountText) else { presentAlert(with: "Veuillez saisir un nombre!")
            priceLabel.text = "0.0"
            return
        }
        if textField.text != "" {
            let total = theAmountText * input
            priceLabel.text = String(format: "%.2f", total)
        }
    }
    
    // MARK: - Methods
    
    private func useData(currencyData: [String: Double]) {
        currencyCode.append(contentsOf: currencyData.keys)
        values.append(contentsOf: currencyData.values)
        pickerView.reloadAllComponents()
        let usd = currencyCode.firstIndex(of: "USD")
        pickerView.selectRow(usd!, inComponent: 0, animated:false)
//        activeCurrency = values[pickerView.selectedRow(inComponent: 0)]
//        updateViews(input: activeCurrency)
    }
    
    private func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - PickerView
extension CurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyCode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyCode[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = values[row]
        updateViews(input: activeCurrency)
    }
}

// MARK: - Keyboard
extension CurrencyViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
