//
//  NetworkModel.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 13/1/24.
//

import Foundation

final class NetworkModel {
    static let shared = NetworkModel()
    
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private let client: APIClientProtocol

    
    private init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func login(
        user: String,
        password: String,
        completion: @escaping (Result<String, DragonBallError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/auth/login"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.encodingFailed))
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        client.jwt(urlRequest) { result in
            switch result {
                case let .success(token):
                    LocalDataModel.save(token: token)
                    completion(.success(token))
            case let .failure(error):
                    completion(.failure(error))
            }
        }
    }
}
