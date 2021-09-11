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
    var activeCode = ""
    
    // MARK: - IBOutlets
    @IBOutlet var textField: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var flagText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        CurrencyService.shared.fetchJSON {(success, currrencyData, timestamp) in
            if success, let currencyData = currrencyData, let timestamp = timestamp {
                self.useData(currencyData: currencyData, timestamp: timestamp)} else {
                    self.presentAlert(error: "Erreur de chargement")
                }
        }
        textField.addTarget(self, action: #selector(updateViews), for: .editingChanged)
        textField.delegate = self
    }
    
    @objc func updateViews() {
        guard let amountText = Double(textField.text!) else {
            if textField.text != "" {self.presentAlert(error: "Veuillez entrer un nombre !")
                priceLabel.text = "0.0"
            }
            return
        }
        if textField.text != "" {
            let total = amountText * activeCurrency
            priceLabel.text = String(format: "%.2f", total)
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    // MARK: - Methods
    
    private func useData(currencyData: [String: Double], timestamp: Double) {
        currencyCode.append(contentsOf: currencyData.keys)
        values.append(contentsOf: currencyData.values)
        pickerView.reloadAllComponents()
        let usd = currencyCode.firstIndex(of: "USD")
        pickerView.selectRow(usd!, inComponent: 0, animated:false)
        updateFlag(activeCode: "US")
        activeCurrency = values[pickerView.selectedRow(inComponent: 0)]
        updateViews()
        let dateInitial = Date(timeIntervalSince1970: TimeInterval(timestamp))
        date.text = "Mise à jour le \(dateInitial)"
        
    }
    
    private func presentAlert(error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func getFlag(from countryCode: String) -> String {
        countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
    @objc func updateFlag(activeCode: String) {
        flagText.text = getFlag(from: activeCode)
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
        activeCode = currencyCode[pickerView.selectedRow(inComponent: 0)]
        var flagCode = activeCode
        flagCode.removeLast()
        updateFlag(activeCode: flagCode)
        updateViews()
    }
}

// MARK: - Keyboard
extension CurrencyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
