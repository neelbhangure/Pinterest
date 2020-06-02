//
//  ImageAPI.swift
//  Pinterest
//
//  Created by neelkant on 02/06/20.
//  Copyright © 2020 appscrip. All rights reserved.
//

import Foundation

struct ImageAPI {
    
    private static var baseUrl = "https://picsum.photos/v2/list"
    private let urlSession = URLSession(configuration: .default)
    public static let shared = ImageAPI()
    private init() {}
    
    
    func getImageList( successHandler: @escaping ([ImageData
        ]) -> Void, errorHandler: @escaping (Error?) -> Void) {
        
        
        
        get(withURL: URLRequest(url: URL(string: ImageAPI.baseUrl)!)) { (data) in
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: APIError.noData)
                return
            }
            
            do {
                let picListResponse = try ImageAPI.decoder.decode([ImageData].self, from: data)
                
                DispatchQueue.main.async {
                    successHandler(picListResponse)
                    errorHandler(nil)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: APIError.serializationError)
            }
        }
    }
    
    private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }
    
}

public enum APIError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}

extension ImageAPI {
    func  get(withURL urlRequest: URLRequest, completion: @escaping (_ data: Data?) -> ()) {
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data, error == nil {
                completion(data)
            }else {
            completion(nil)
            }
        }.resume()
    }
}

extension ImageAPI {
    public static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            throw DecodingError.typeMismatch(Date.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode date"))
        })
        return decoder
    }
    
    public static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        encoder.dateEncodingStrategy = .formatted(formatter)
        return encoder
    }
}
