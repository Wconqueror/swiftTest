//
//  LoginViewModel.swift
//  Test
//
//  Created by 王得胜 on 2019/11/12.
//  Copyright © 2019 王得胜. All rights reserved.
//

import Foundation
import SwiftyJSON


class LoginViewModel : NSObject{
    var delegate : LoginViewModelDelegate?
    init(delegate : LoginViewModelDelegate){
        self.delegate = delegate
    }
    
    func login(account:String,pwd:String){
        let parameters:[String:String] = ["mobile":account,
                                          "pwd":pwd]
        
        
        
    }
}

class UserModel: NSObject,NSCoding {
    
    @objc var name      : String?   = ""
    @objc var mobile    : String?   = ""
    @objc var catname   : String?   = ""
    @objc var shopname  : String?   = ""
    @objc var title     : String?   = ""
    @objc var face      : String?   = ""
    @objc var token     : String?   = ""
    @objc var plan      : NSNumber? = 0
    @objc var track     : NSNumber? = 0
    @objc var id        : NSNumber? = nil
    @objc var cid       : NSNumber? = nil
    @objc var shopid    : NSNumber? = nil
    
    required init?(coder aDecoder : NSCoder) {
        super.init()
        self.name     = aDecoder.decodeObject(forKey: "name") as? String
        self.mobile   = aDecoder.decodeObject(forKey: "mobile") as? String
        self.catname  = aDecoder.decodeObject(forKey: "catname") as? String
        self.token    = aDecoder.decodeObject(forKey: "token") as? String
        self.id       = aDecoder.decodeObject(forKey: "id") as? NSNumber
        self.cid      = aDecoder.decodeObject(forKey: "name") as? NSNumber
        self.shopid   = aDecoder.decodeObject(forKey: "shopid") as? NSNumber
        self.shopname = aDecoder.decodeObject(forKey: "shopname") as? String
        self.face     = aDecoder.decodeObject(forKey: "face") as? String
        self.plan     = aDecoder.decodeObject(forKey: "plan") as? NSNumber
        self.track    = aDecoder.decodeObject(forKey: "track") as? NSNumber
        
    }
    
    init(dic:[String:Any]){
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    //编码成object,哪些属性需要归档，怎么归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name,forKey: "name")
        aCoder.encode(mobile,forKey:"mobile")
        aCoder.encode(token,forKey:"token")
        aCoder.encode(catname,forKey:"catname")
        aCoder.encode(id,forKey:"id")
        aCoder.encode(shopid,forKey:"shopid")
        aCoder.encode(cid,forKey:"cid")
        aCoder.encode(shopname,forKey:"shopname")
        aCoder.encode(face,forKey:"face")
        aCoder.encode(plan,forKey:"plan")
        aCoder.encode(track,forKey:"track")
    }
}

protocol LoginViewModelDelegate {
    func loginSuccess(user:UserModel)
}
