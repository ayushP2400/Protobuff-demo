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
