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
        currency()
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

    private func currency() {
        let session = URLSession(configuration: .default)
        CurrencyService(session: session).fetchJSON {(error, currency) in
            if let currency = currency {
                self.useData(currency: currency)} else {
                    self.presentAlert(error: error?.localizedDescription ?? "Erreur de chargement")
                }
        }
    }

    private func useData(currency: CurrencyModel) {
        currencyCode.append(contentsOf: currency.currencyData.keys)
        values.append(contentsOf: currency.currencyData.values)
        pickerView.reloadAllComponents()
        let usd = currencyCode.firstIndex(of: "USD")
        pickerView.selectRow(usd!, inComponent: 0, animated: false)
        activeCurrency = values[pickerView.selectedRow(inComponent: 0)]
        updateViews()
        flagText.text = getFlag(from: "US")
        countryLabel.text = CountryNames().codeToCountry["USD"]
        let dateInitial = Date(timeIntervalSince1970: TimeInterval(currency.timestamp))
        date.text = "Mise à jour le \(dateInitial)"
    }

    /* Solution to turn a country code into a emoji flag found at
     https://stackoverflow.com/questions/30402435/swift-turn-a-country-code-into-a-emoji-flag-via-unicode */
    func getFlag(from countryCode: String) -> String {
        countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}
