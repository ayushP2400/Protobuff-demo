//
//  ViewController.swift
//  ProtobufDemo
//
//  Created by love on 28/01/22.
//

import UIKit
import SwiftProtobuf

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailLogin()
    }

    
    func emailLogin() {
        var request = EmailLoginRequest.init()
        request.deviceType = .ios
        request.deviceName = "iPhone 12"
        request.osVersion = "10.0"
        request.deviceID = "test device id"
        request.password = "mypass"
        request.username = "name"
        
        let requestTwo = EmailLoginRequest.with {
            $0.deviceType = .ios
            $0.deviceName = "iPhone 12"
            $0.osVersion = "10.0"
            $0.deviceID = "test device id"
            $0.password = "mypass"
            $0.username = "name"
        }
        
        do {
            let jsonData: Data = try request.jsonUTF8Data()
            var httpRequest = URLRequest.init(url: URL.init(string: "http://54.196.103.156:4000/api/login/loginEmailUsername")!)
            httpRequest.httpBody = jsonData
            httpRequest.httpMethod = "POST"
            
            performHTTPRequest(with: httpRequest) { result, error in
                if let error = error {
                    debugPrint(error)
                } else {
                    guard let result = result, let dataInString = String(data: result, encoding: .utf8) else {
                        return
                    }
                    debugPrint(dataInString)
                }
            }

        } catch {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    func performHTTPRequest(with urlRequest: URLRequest, completion: @escaping (Data?, String?) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if let error = error {
                completion(nil, error.localizedDescription)
            } else {
                if let data = data {
                    completion(data, nil)
                } else {
                    completion(nil, error?.localizedDescription)
                }
            }
        }.resume()
    }

}

