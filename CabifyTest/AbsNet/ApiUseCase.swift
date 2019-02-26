//
//  ApiUseCase.swift
//  AbsNet
//
//  Created by Santiago Franco García on 23/5/18.
//  Copyright © 2018 Santiago Franco. All rights reserved.
//

import Foundation

open class ApiUseCase<Input: Codable, Output: Codable>  {
    
    public typealias UseCaseSuccess = (Output?) -> Void
    public typealias UseCaseFailure = (Error) -> Void
    
    open var input: Input?
    var method: AbsNetMethod = .get
    
    open var success: UseCaseSuccess?
    open var failure: UseCaseFailure?
    
    public init() {}
    
    /**
     */
    open func endpoint(with input: Input?) -> String{
        return ""
    }
    
    /**
     */
    fileprivate func parse(json: String) {
        
        if let response = json.toObject(Output.self) {
            success?(response)
            return
        }
        
        failure?(AbsNetError.parseError)
    }
    
    /**
     */
    open func getHeaders() -> [AbsNetHeader] {
        return []
    }
    
    /**
     */
    open func getMethod() -> AbsNetMethod {
        return .get
    }
    
}


extension ApiUseCase {
    
    /**
     */
    var session: URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        return URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    /**
     */
    var request : URLRequest? {
        
        guard let configuration = ApiService.shared.configuration else {
            fatalError("AbsNet: No configuration provided. You should provide it to the correct performance of framework")
        }
        
        guard let url = URL(string: "\(configuration.url)\(endpoint(with: self.input))") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = self.getMethod().rawValue
        
        print("AbsNet: \(request.httpMethod!) ----> \(url.absoluteString)")
        
        if let jwt = configuration.jwt {
            request.addValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Close", forHTTPHeaderField: "Connection")
        
        if !self.getHeaders().isEmpty {
            for header in self.getHeaders() {
                print(header.key, header.value)
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        request.allHTTPHeaderFields?.forEach({ (key, value) in
            print("AbsNet: \(key): \(value)")
        })
        
        if let postString = input?.toJsonString(),
            self.getMethod() != .get {
            
            print("AbsNet: HTTP BODY ---->", postString)
            request.httpBody = postString.data(using: .utf8)
        }
        
        return request
        
    }
    
    /**
     */
    open func execute() {
        
        guard let request = self.request else {
            failure?(AbsNetError.urlError)
            return
        }
        
        let task = self.session.dataTask(with: request) {
            
            (data, response, error ) -> Void in
            
            guard let data = data else {
                self.failure?(AbsNetError.dataError)
                return
            }
            
            guard error == nil else {
                self.failure?(error!)
                return
            }
            
            guard let jsonResponse = String.init(data: data, encoding: .utf8) else {
                self.failure?(AbsNetError.dataError)
                return
            }
            
            let httpCode = response?.getStatusCode()
            let codeText = httpCode == nil ? "No http code" : "\(httpCode!)"
            let textJson = jsonResponse == "" ? "No json response" : jsonResponse
            print("AbsNet: RESPONSE ----> \(codeText)", textJson)
            self.parse(json: jsonResponse)
        }
        
        task.resume()
        
        
    }
    
    
}
