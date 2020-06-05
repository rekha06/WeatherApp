//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Rekha Ranjan on 6/4/20.
//  Copyright © 2020 Rekha Ranjan. All rights reserved.
//

import UIKit
import SystemConfiguration

enum RequestType:String {
    case get  = "GET"
    case post = "POST"
}
struct NetworkManagerResult {
    fileprivate(set) var status : String?
    fileprivate(set) var message : String?
    fileprivate(set) var result : Any?
    fileprivate(set) var error : String?
}

enum NetworkManagerActions : String {
    case action1 = "q"
}


class NetworkManager {

    public var baseUrl = App.baseUrl
    public static let shared = NetworkManager()
    private lazy var session = URLSession(configuration: URLSessionConfiguration.default)
    private init() {}
    @objc private func statusManager(_ notification: Notification) {
        
    }
    
    public func get(_ url:String, params:[String:Any] = [:], completionHandler: @escaping (NetworkManagerResult) -> Void) {
        self.service(.get, url: "\(baseUrl)\(NetworkManagerActions.action1.rawValue)", parameters: params, completionHandler: completionHandler)
    }
    
    private func service(_ method:RequestType, url:String, parameters:[String:Any], completionHandler: @escaping (NetworkManagerResult) -> Void) {
        
        let request = self.getUrlRequest(url+"=\(parameters["City"]!)&appid=\(App.ApiKey)", [:], method: method)
        
        let dataTask = session.dataTask(with: request as URLRequest) {data, response, error in
        
        DispatchQueue.main.async {
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(NetworkManagerResult(error: "Unable to get data from server"))
                return
            }
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                completionHandler(NetworkManagerResult(error: error!.localizedDescription))
                return
            }
            
            guard let res = response as? HTTPURLResponse,res.statusCode == 200 else {
                print("Error: did not receive data")
                completionHandler(NetworkManagerResult(error: "Something went wrong while getting data from server"))
                return
            }
           // print(String(data: responseData, encoding: String.Encoding.utf8) ?? "")
            let json = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String:Any]
            let status = json?["status"] as? String
            let message = json?["error_message"] as? String
            let result = json?["data"] as? [String:Any]
            let result2 = json?["data"] as? [[String:Any]]
            completionHandler(NetworkManagerResult(status: status, message: message, result: (result ?? result2) ?? json))
            
         }
        }
        dataTask.resume()
        
    }
    var service : URLSessionDataTask!
    
    private func getUrlRequest(_ url:String, _ params: [String:Any], method:RequestType)-> NSMutableURLRequest {
        
       
        
        let request = NSMutableURLRequest()
        
        let urlComp = NSURLComponents(string: url)!
        
        var items = [URLQueryItem]()
        
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: "\(value)"))
        }
        
        items = items.filter{!$0.name.isEmpty}
        
        if method == .post {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = params.percentEncoded()
        }else {
            if !items.isEmpty {
                urlComp.queryItems = items
            }
        }
        request.url = urlComp.url
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 100
        request.httpMethod = method.rawValue
        

        self.addHeaderValues(["Content-Type":"application/json",
                              "Accept":"application/json"], request: request)
        return request
    }
    
    private func addHeaderValues(_ headers: [String:String], request: NSMutableURLRequest) {
        
        headers.forEach { (key,value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
    }

}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}
