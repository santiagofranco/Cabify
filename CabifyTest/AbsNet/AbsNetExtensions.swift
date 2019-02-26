//
//  Extensions.swift
//  AbsNet
//
//  Created by Santiago Franco García on 23/5/18.
//  Copyright © 2018 Santiago Franco. All rights reserved.
//

import Foundation

extension Encodable {
    
    func toJsonString() -> String? {
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        }
        catch {
            return nil
        }
    }
    
}

extension String {
    
    func toObject<T : Decodable>(_ type : T.Type) -> T? {
        
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let object = try jsonDecoder.decode(T.self, from: data)
            return object
        }
        catch {
            return nil
            
        }
        
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        
        return nil
    }
}
