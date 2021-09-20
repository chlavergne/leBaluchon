//
//  TranslateViewController.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 16/09/2021.
//

import UIKit

class TranslateViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var frenchText: UITextView!
    @IBOutlet var englishText: UITextView!
    @IBOutlet var englishPlaceholder: UITextField!
    @IBOutlet var frenchPlaceholder: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frenchText.delegate = self
    }
    
    // MARK: - IBActions
    @IBAction func dismissKeyboard(_ sender: Any) {
        frenchText.resignFirstResponder()
        if frenchText.text == "" {
            englishPlaceholder.placeholder = "Traduction (Anglais)"
            frenchPlaceholder.placeholder = "Tapez un texte à traduire (Français)"
        }
    }
    
    @IBAction func clearText(_ sender: Any) {
        frenchText.text = ""
        englishText.text = ""
        englishPlaceholder.placeholder = "Traduction (Anglais)"
        frenchPlaceholder.placeholder = "Tapez un texte à traduire (Français)"
    }
    
    // MARK: -Methods
    func translateText() {
        let TextToTranslate = frenchText.text!
        print(TextToTranslate)
        TranslateService.shared.fetchJSON(text: TextToTranslate) {(success, translation) in
            if success {self.englishText.text = translation} else {
                print(translation)
                self.presentAlert(error: "Erreur de chargement")
            }
        }
    }
}

