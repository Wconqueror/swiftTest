//
//  TokenManager.swift
//  Test
//
//  Created by 王得胜 on 2019/11/12.
//  Copyright © 2019 王得胜. All rights reserved.
//

import Foundation

class TokenManager: NSObject {
    class func saveToken(user:UserModel) {
        let data : Data = NSKeyedArchiver.archivedData(withRootObject: user)
        
    }
    
    class func readToken() -> (UserModel){
        
    }
    
}
