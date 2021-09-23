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
    @IBOutlet var countryLabel: UILabel!
    
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
    
    // MARK: - IBAction
    @IBAction func dismissKeyboard(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    // MARK: - Methods
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
    
    private func useData(currencyData: [String: Double], timestamp: Double) {
        currencyCode.append(contentsOf: currencyData.keys)
        values.append(contentsOf: currencyData.values)
        pickerView.reloadAllComponents()
        let usd = currencyCode.firstIndex(of: "USD")
        pickerView.selectRow(usd!, inComponent: 0, animated:false)
        activeCurrency = values[pickerView.selectedRow(inComponent: 0)]
        updateViews()
        flagText.text = getFlag(from: "US")
        countryLabel.text = CountryNames().codeToCountry["USD"]
        let dateInitial = Date(timeIntervalSince1970: TimeInterval(timestamp))
        date.text = "Mise à jour le \(dateInitial)"
    }
    
    func getFlag(from countryCode: String) -> String {
        countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}
