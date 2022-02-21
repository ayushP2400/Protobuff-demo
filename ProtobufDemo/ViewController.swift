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
        var helloRequest = Helloworld_HelloRequest.init()
        helloRequest.name = "Ayush"
        GRPCManager.shared.testSayHello(with: helloRequest)
        GRPCManager.shared.testSayHi(with: helloRequest)
    }
    
    
}

import Foundation
import GRPC
import SwiftProtobuf
import NIO
import NIOSSL

class GRPCManager {
    
    var connection: ClientConnection?
    static let shared = GRPCManager()
    
    private init() {
        let conf = ClientConnection.Configuration.default(target: .hostAndPort("54.67.87.25", 50051), eventLoopGroup: MultiThreadedEventLoopGroup(numberOfThreads: 1))
        connection = ClientConnection.init(configuration: conf)
    }
    func testSayHello(with request: Helloworld_HelloRequest) {
        guard let connection = connection else { return }
        let client = Helloworld_GreeterClient(channel: connection)
        _ = client.sayHello(request).response.always { result in
            switch result {
            case let .success(helloResponse):
                print(helloResponse.message)
            case let .failure(error):
                print(error)
            }
        }
    }
    func testSayHi(with request: Helloworld_HelloRequest) {
        guard let connection = connection else { return }
        let client = Helloworld_GreeterClient(channel: connection)
        _ = client.sayHi(request).response.always { result in
            switch result {
            case let .success(helloResponse):
                print(helloResponse.message)
            case let .failure(error):
                print(error)
            }
        }
    }
}
