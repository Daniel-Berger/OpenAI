//
//  APICaller.swift
//  SwiftGPT3
//
//  Created by daniel berger on 12/18/22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    @frozen enum Constants {
        // Enter API key here
        static let key = ""
    }
    
    private init() {}
    
    private var client: OpenAISwift?
    
    public func setup() {
        let client = OpenAISwift(authToken: Constants.key)
    }

    public func getResponse(input: String, completion: @escaping (Result<String, Error>) -> Void) {
        client?.sendEdits(with: input, model: .gpt3(.davinci), completionHandler: { result in
//        client?.sendCompletion(with: input, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
