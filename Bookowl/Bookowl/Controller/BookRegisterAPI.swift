//
//  BookRegisterAPI.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/29.
//

import Foundation
import GRPC
class BookRegisterAPI : NSObject{
    override init() {
        super.init()
    }
    
    func sendRegisterBookrequest(){
        let client = Bookowl_BookClient.init(channel: "localhost" as! GRPCChannel)
        var request = Bookowl_BookRegisterRequest()
        request.bookmarkID = 0
        let res = try? client.register(request)
        print(res!.response)
    }
    
}
