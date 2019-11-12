//
//  DNetWorkTool.swift
//  Test
//
//  Created by 王得胜 on 2019/11/12.
//  Copyright © 2019 王得胜. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MBProgressHUD


class DNetWorkTool: NSObject {
    var hud:MBProgressHUD?
    static let instance: DNetWorkTool = DNetWorkTool()
        
    class func shared() -> DNetWorkTool{
        return instance
    }
    
    func dnetTool_post(apiPath:String,parameters:[String:Any],isShowHud:Bool = false,complete:@escaping(_ isComplete:Bool, _ result:Any) -> ()) -> (){
            print(parameters)
            if isShowHud {
                if self.hud != nil {
                    self.hud!.hide(animated: false)
                    self.hud = nil
                }
                
                hud = MBProgressHUD.showAdded(to:UIApplication.shared.keyWindow!, animated: true)
                hud?.backgroundView.isUserInteractionEnabled = true
                hud?.removeFromSuperViewOnHide = true
                hud?.backgroundView.color = UIColor.black.withAlphaComponent(0.5)
            }
            
            let user = TokenManager.readToken()
            let header:HTTPHeaders = ["token":user.token ?? ""]
            
            Alamofire.request(ServerURL+apiPath, method: .post, parameters:parameters , encoding: URLEncoding.default, headers:header ).responseJSON { response in
                if isShowHud && self.hud != nil {
                    self.hud!.hide(animated: true)
                }
                
                if let Error = response.result.error
                {
                    print(Error)
                    DHud.show(msg: Error.localizedDescription, time: 2.0)
                }
                else if let jsonresult = response.result.value {
                    print("\(apiPath):" + "\(JSON(jsonresult))")
                    let code = JSON(jsonresult)["code"].intValue
                    if code != 1 {
                        let msg = JSON(jsonresult)["msg"].stringValue
                        DHud .show(msg: msg, time: 2.0)
                    } else {
                        complete(true, jsonresult)
                    }
                }
            }
        }
        
        func dnetTool_get(apiPath:String,parameters:[String:Any],isShowHud:Bool = false,complete:@escaping(_ isComplete:Bool, _ result:Any) -> ()) -> (){
            print(parameters)
            if isShowHud {
                if self.hud != nil {
                    self.hud!.hide(animated: false)
                    self.hud = nil
                }
                
                hud = MBProgressHUD.showAdded(to:UIApplication.shared.keyWindow!, animated: true)
                hud?.isUserInteractionEnabled = true
                hud?.removeFromSuperViewOnHide = true
                hud?.backgroundView.color = UIColor.black.withAlphaComponent(0.5)
            }
            
            let user = TokenManager.readToken()
            let header:HTTPHeaders = ["token":user.token ?? ""]
    //        print("token:\(user.token ?? "无无无无无无无无无无无无无无无")")
            Alamofire.request(ServerURL+apiPath, method: .get, parameters:parameters , encoding: URLEncoding.default, headers:header ).responseJSON { response in
                if isShowHud && self.hud != nil {
                    self.hud!.hide(animated: true)
                }

                if let Error = response.result.error
                {
                    print(Error)
                    DHud.show(msg: Error.localizedDescription, time: 2.0)
                }
                else if let jsonresult = response.result.value {
                    print("\(apiPath):" + "\(JSON(jsonresult))")
                    let code = JSON(jsonresult)["code"].intValue
                    if code != 1 {
                        let msg = JSON(jsonresult)["msg"].stringValue
                        DHud .show(msg: msg, time: 2.0)
                    } else {
                        complete(true, jsonresult)
                    }
                }
            }
        }
        
        func dnetTool_upload(apiUrl:String,parameters:[String:Any],images:[UIImage],isShowHud:Bool,complete:@escaping(_ isComplete:Bool, _ result:Any) -> ()) -> () {
            
            hud = MBProgressHUD.showAdded(to:UIApplication.shared.keyWindow!, animated: true)
            hud?.isUserInteractionEnabled = false
            hud?.removeFromSuperViewOnHide = true
            hud?.backgroundView.color = UIColor.black.withAlphaComponent(0.5)
            
            let names:[String] = parameters["names"] as! [String]
            let user = TokenManager.readToken()
            let header:HTTPHeaders = ["token":user.token ?? ""]
            var newParameters = parameters
            newParameters.removeValue(forKey: "names")
            Alamofire.upload(
                
                multipartFormData: { multipartFormData in
                    //采用post表单上传
                    // 参数解释：
                    //withName:和后台服务器的name要一致 ；fileName:可以充分利用写成用户的id，但是格式要写对； mimeType：规定的，要上传其他格式可以自行百度查一下
                    for img:UIImage in images {
                        let index = images.firstIndex(of: img)
                        let name = names[index!]
                        let fileName:String = parameters[name]! as! String ;
                        let imageData:Data = img.jpegData(compressionQuality: 1)!
                        multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: "image/jpeg")
                    }
                    
                    // 其余参数绑定
                    for (key, value) in newParameters {
                        assert(value is String)
                        multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!,withName:key)
                    }
                    
                   
                    
            },to:ServerURL+apiUrl,headers:header, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    //连接服务器成功后，对json的处理
                    if self.hud != nil {
                        self.hud!.hide(animated: true)
                    }
                    
                    upload.responseJSON { response in
                        //解包 zxg-崩溃点
                        let jsonresult = response.result.value!
    //                    print("\(apiUrl)" + "\(JSON(jsonresult))")
                        let code = JSON(jsonresult)["code"].intValue
                        if code != 1 {
                            let msg = JSON(jsonresult)["msg"].stringValue
                            DHud .show(msg: msg, time: 2.0)
                        } else {
                            complete(true, jsonresult)
                        }
                        
                    }
                    //获取上传进度
                    upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    }
                case .failure(let encodingError):
                    //打印连接失败原因
                    DHud.show(msg: encodingError.localizedDescription, time: 2.0)
                    print(encodingError)
                }
            })
        }
    
}
