//
//  ImageAPI.swift
//  Pinterest
//
//  Created by neelkant on 02/06/20.
//  Copyright © 2020 appscrip. All rights reserved.
//

import Foundation

struct ImageAPI {
    /// base URL  string
    private static var baseURL = "https://picsum.photos"
    /// instance of URLSession class
    private let urlSession = URLSession(configuration: .default)
    /// single instance  of ImageAPI class shared to complete application
    public static let shared = ImageAPI()
    
    private init() {}
    
    /**
    Asynchronus call to get json data from server .
     
     - Parameter successHandler: escaping clousre which excutes once data is succesfully retrived from api call with [ImageData]as parameter.
     - Parameter errorHandler: excutes with Error as parameter when there is any problem from api call, nil when data is retrieved successfully .
   
     */
    func getImageList( successHandler: @escaping ([ImageData
        ]) -> Void, errorHandler: @escaping (Error?) -> Void) {
        
        
        
        get(withURL: URLRequest(url: URL(string: ImageAPI.baseURL + "/v2/list")!)) { (data) in
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
    /**
       Get response from urlrequest .
        
        - Parameter urlRequest:  URLRequest instance to be processed to get response from api call.
        - Parameter completion: excutes with Data as parameter when data is present response body, nil when body is not present .
        
        */
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
    /**
        computed `JSONDecoder` instance.

        Computation depends on the decoding strategy set here, and which is
        used to set the date format which we are expcting from server to send.

    */
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
    
   
}
