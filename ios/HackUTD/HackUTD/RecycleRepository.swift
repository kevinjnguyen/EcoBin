//
//  RecycleRepository.swift
//  HackUTD
//
//  Created by Kevin J Nguyen on 2/23/19.
//  Copyright © 2019 Kevin J Nguyen. All rights reserved.
//

import Foundation
import SwiftGRPC

class RecycleRepository {
    
    static let RASPBERRY_IP = "127.0.0.1:50051"
    static let shared = RecycleRepository()
    private init() {}

    private let client = Hackutd_recycleServiceClient.init(address: RASPBERRY_IP, secure: false)
    
    func sendTestEcho() throws {
        var dummyRequest = Hackutd_Status()
        dummyRequest.message = "Hello everyone."
        try client.testEcho(dummyRequest)
    }
}
