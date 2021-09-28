//
//  TranslateService.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 16/09/2021.
//

import Foundation

class TranslateService {
    
    // MARK: - Properties
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - Methods
    func fetchJSON(text: String, callback: @escaping (Error?, TranslateModel?) -> Void) {
        let request = createTranslateRequest(text: text)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(error, nil)
                    return
                }
                do {
                    let responseJSON = try JSONDecoder().decode(TranslateResponse.self, from: data)
                    let translation = TranslateModel(apiModel: responseJSON)
                    callback(nil, translation)
                } catch  {
                    callback(error, nil)
                    return
                }
            }
        }
        task.resume()
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
