//
//  UIViewController+Additions.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 17/09/2021.
//

import UIKit

extension UIViewController {
    func presentAlert(error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension CurrencyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension TranslateViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        englishPlaceholder.placeholder = ""
        translateText()
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        frenchPlaceholder.placeholder = ""
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return true
        }
        return true
    }
}

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
        flagText.text = getFlag(from: flagCode)
        countryLabel.text = CountryNames().codeToCountry[activeCode]
        updateViews()
    }
}
