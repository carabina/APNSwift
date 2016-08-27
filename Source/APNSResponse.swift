//
//  APNSResponse.swift
//  Smart APN
//
//  Created by Kaunteya Suryawanshi on 23/07/16.
//  Copyright © 2016 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation
extension APNS {
    struct Response {

        let apnsId: String?
        let serviceStatus: APNS.ServiceStatus
        var errorReason: APNS.Error?
        let deviceToken: String

        init(deviceToken: String, response: NSHTTPURLResponse, data: NSData?) {
            self.deviceToken = deviceToken
            apnsId = response.allHeaderFields["apns-id"] as? String
            serviceStatus = APNS.ServiceStatus(rawValue: response.statusCode)!

            if serviceStatus != .Success {
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                if let reason = json["reason"] as? String {
                    errorReason = APNS.Error(rawValue: reason)
                }
            }
        }
    }
}