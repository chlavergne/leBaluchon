//
//  TranslateService.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 16/09/2021.
//

import Foundation

class TranslateService {
    
    static var shared = TranslateService()
    
    private var task: URLSessionDataTask?
    
    func fetchJSON(text: String, callback: @escaping (Bool, String) -> Void) {
        let request = createTranslateRequest(text: text)
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, "Error")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {callback(false, "Error")
                    return}
                guard let responseJSON = try? JSONDecoder().decode(TranslateResponse.self, from: data)  else {
                    callback(false, "Error")
                    return
                }
        
                let translation = responseJSON.data.translations[0].translatedText
                callback(true, translation)
            }
        }
        task?.resume()
    }
    
    private func createTranslateRequest(text: String) -> URLRequest {
        var urlConponents = URLComponents(string: "https://translation.googleapis.com/language/translate/v2")!
        urlConponents.queryItems = [URLQueryItem(name: "q", value: text),
                                    URLQueryItem(name: "key", value: "AIzaSyCdB22R9rxaEK69Jh49vMNr4jgNK3s_xM4"), URLQueryItem(name: "source", value: "fr"),
                                    URLQueryItem(name: "target", value: "en")]
        var request = URLRequest(url: urlConponents.url!)
        request.httpMethod = "GET"
        return request
    }
}
