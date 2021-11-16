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
        let client = Bookowl_BookClient.init(channel: address as! GRPCChannel)
        var request = Bookowl_RegisterBookRequest()
        request.isbn = "aaaa"
        let res = try? client.registerBook(request, callOptions: nil)
        print(res!.response)
    }
    
}
