//
//  DeviseViewController.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 05/09/2021.
//

import UIKit

class DeviseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {


    // MARK: - IBOutlets
    @IBOutlet var textField: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var priceLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func dismissKeyboard(_ sender: Any) {
        textField.resignFirstResponder()
    }
    // MARK: - Properties
    var currencyCode: [String] = []
    var values: [Double] = []
    var activeCurrency = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        fetchJSON()
        textField.addTarget(self, action: #selector(updateViews), for: .editingChanged)
    }
    
    @objc func updateViews(input: Double) {
        guard let amountText = textField.text, let theAmountText = Double(amountText) else { return }
        if textField.text != "" {
            let total = theAmountText * activeCurrency
            priceLabel.text = String(format: "%.2f", total)
        }
    }
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Method
    
    private func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func fetchJSON() {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=fbaa144280f40b3d007443ebae931f68&base=EUR&symbols=USD,CAD,CHF,CNY,BRL,GBP,RUB,AUD,DKK,HKD,IDR") else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            // handle any errors if there any
            if error != nil {
                print(error!)
                return
            }
            // safely unwrap the data
            guard let safeData = data else {return}
            // decode the JSON
            do {
                let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                self.currencyCode.append(contentsOf: results.rates.keys)
                self.values.append(contentsOf: results.rates.values)
                DispatchQueue.main.async {
                    self.pickerView.reloadAllComponents()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
