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
    
    static let RASPBERRY_IP = "172.20.10.3:50051"
    static let shared = RecycleRepository()
    private init() {}

    private let client = Hackutd_recycleServiceClient.init(address: RASPBERRY_IP, secure: false)
    
    func sendTestEcho() throws {
        var dummyRequest = Hackutd_Status()
        dummyRequest.message = "Hello everyone."
        try client.testEcho(dummyRequest)
    }
    
    func shouldRecycle() throws {
        let decision = Hackutd_Decision.recycle
        try sendMoveTrashDividers(type: decision)
    }
    
    func shouldLandfill() throws {
        let decision = Hackutd_Decision.landfill
        try sendMoveTrashDividers(type: decision)
    }
    
    func shouldCompost() throws {
        let decision = Hackutd_Decision.compost
        try sendMoveTrashDividers(type: decision)
    }
    
    func shouldReject() throws {
        let decision = Hackutd_Decision.reject
        try sendMoveTrashDividers(type: decision)
    }
    
    private func sendMoveTrashDividers(type: Hackutd_Decision) throws {
        var action = Hackutd_Action()
        action.decision = type
        try client.moveTrashDividers(action)
    }
}
