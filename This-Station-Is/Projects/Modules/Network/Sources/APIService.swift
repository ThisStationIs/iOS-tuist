//
//  APIService.swift
//  Network
//
//  Created by Muzlive_Player on 2023/12/15.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol APIService {
    func request<R: Decodable, E: RequestResponsable>(with endpoint: E, completion: @escaping (Result<R, Error>) -> Void) where E.Response == R
}

public class APIServiceManager: APIService {
    let session: URLSessionable
    
    public init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    public func request<R, E>(with endpoint: E, completion: @escaping (Result<R, Error>) -> Void) where R : Decodable, R == E.Response, E : RequestResponsable {
        do {
            let urlRequest = try endpoint.getUrlRequest()
            print("👀 fullPath : \(urlRequest)")
            session.dataTask(with: urlRequest) {  data, response, error in
                self.checkError(with: data, response, error, completion: { result in
//                    print("### json: \(JSON(data))")
                    switch result {
                    case .success(let success):
                        completion(self.decode(data: success))
                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                })
            }.resume()
        } catch {
            completion(.failure(NetworkError.requestError))
        }
    }
    
    private func checkError(with data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping(Result<Data, Error>) -> ()) {
        if let error = error {
            print("😈 Error : \(error)")
            completion(.failure(error))
            return
        }

        // TODO: 에러 조건 추가
        guard let response = response as? HTTPURLResponse else {
            print("😈 response : \(response?.description)")
            completion(.failure(NetworkError.noResponse))
            return
        }

        guard (200...299).contains(response.statusCode) else {
            print("😈 statusCode : \(response.statusCode)")
            completion(.failure(NetworkError.statusCodeError))
            return
        }

        guard let data = data else {
            completion(.failure(NetworkError.noData))
            return
        }
        
        completion(.success(data))
    }
    
    private func decode<T: Decodable>(data: Data) -> Result<T, Error> {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
//            print("### decodedData is \(decodedData)")
            return .success(decodedData)
        } catch {
            return .failure(NetworkError.decodeError)
//        TODO: hmm...
        }
    }
}
