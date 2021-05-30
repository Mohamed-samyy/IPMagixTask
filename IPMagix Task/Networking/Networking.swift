//
//  Networking.swift
//  //  IPMagix Task
//
//  Created by Mohamed Samy on 5/30/21.
//


import UIKit
import Alamofire


typealias Handler = (_ response:Any? ,_ error:String?) -> Void

class Networking: NSObject, RequestInterceptor{
    

    class func RequestAPI<T : Codable>(baseUrl : String,method:HTTPMethod, params: [String : Any]? = nil ,headers : HTTPHeaders? = nil,encoding : ParameterEncoding = JSONEncoding.default,model : T? = nil ,completionHandler: @escaping Handler)   {



        print("FULL_PATH : ",baseUrl)
        print("FULL_PARAMS : ",params ?? [:])
        
        
        AF.request(baseUrl,method: method, parameters: params, encoding: encoding).validate(statusCode: 200...300)
            .responseJSON { (response) in



            if response.error != nil && response.response?.statusCode == nil {
                completionHandler(nil,response.error?.localizedDescription)

                Alert.show(message: response.error?.localizedDescription ?? "There is no internet connection".localized)
                return
            }

            
            print(response.result ?? "")

            switch response.response?.statusCode ?? 0 {

            case 200..<299: mapResopnse(response: response.value as! [String : Any], model: model, completionHandler: completionHandler)

            case 401 : completionHandler(nil, "Not Authorized")
            case 422 : completionHandler(nil, "Error")
            case 404 : completionHandler(nil, "Not Authorized")
            case 403 : completionHandler(nil, "Token Expire")
            case 500 : completionHandler(nil, "service Error")
            case nil : completionHandler(nil, "service Error")
                Alert.show(message: "There is a server problem, please try again".localized)
            default:
                completionHandler(nil, response.error?.localizedDescription)
            }
        }
    }
    

    static func mapResopnse<TModel: Codable>(response : Any ,model : TModel,completionHandler: @escaping Handler ) {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: response
                , options: .prettyPrinted)
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            let data = reqJSONStr?.data(using: .utf8)
            let jsonDecoder = JSONDecoder()
            let allResponse = try jsonDecoder.decode(TModel.self, from: data!)
            completionHandler(allResponse, nil)
                       
        }
        catch {
              completionHandler(nil,error.localizedDescription)
        }

    }
}



