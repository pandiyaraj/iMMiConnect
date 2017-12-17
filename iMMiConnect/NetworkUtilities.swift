//
//  NetworkUtilities.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 09/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit


extension URLSession
{
    /// Return data from synchronous URL request
    public func requestSynchronousData(request: NSURLRequest) -> (NSData?, URLResponse?) {
        var data: NSData? = nil
        var response: URLResponse? = nil
        let group = DispatchGroup()
        group.enter()
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (taskData, taskResponse, taskError) in
            data = taskData as NSData?
            response = taskResponse
            if data == nil, let taskError = taskError {print(taskError)}
            group.leave()
        }
        task.resume()
        return (data,response)
    }
}

public class NetworkUtilities {
    
    
    static var refreshActionName = ""
    static var refreshHttpMethod = ""
    static var refreshRequestBody:AnyObject?
    static var refreshcontentType = ""
    
    
    /**
     create session
     
     - parameter contentType: either JSON OR URLENCODED
     
     - returns: URLSession
     */
    static func getSessionWithContentType(contentType : String) -> URLSession {
        let sessoinConfiguration = URLSessionConfiguration.default
        sessoinConfiguration.httpAdditionalHeaders = ["content-type":contentType]
        let session : URLSession  = URLSession.init(configuration: sessoinConfiguration)
        return session
    }
    
    /**
     Create mutable url request to send the server
     
     - parameter actionName:  which action to be performed login
     - parameter httpMethod:  either POST OR GET OR PUT OR DELETE
     - parameter requestBody: parameters
     - parameter contentType: either JSON OR URLENCODED
     
     - returns: URLRequest
     */
    
    
    
    static func getUrlRequest(urlString:String , httpMethod : String, requestBody: AnyObject?,contentType : String) -> NSMutableURLRequest {
        
        let requestUrl = NSURL.init(string: urlString)
        let request  = NSMutableURLRequest.init(url: requestUrl! as URL)
        request.httpMethod = httpMethod
        request.timeoutInterval = 120
        
        var jsonData = Data()
        if requestBody != nil {
            if contentType == Constants.CommonValues.jsonApplication{
                do {
                    jsonData = try JSONSerialization.data(withJSONObject: requestBody!)
                    // here "jsonData" is the dictionary encoded in JSON data
                    
                    //#-- For checking given format is json or not
                    let jsonString = NSString.init(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                    print(jsonString as Any);
                    
                    request.httpBody? =  jsonData
                    let postLength = String(jsonData.count)
                    request.setValue(contentType, forHTTPHeaderField: "Content-type")
                    request.setValue(postLength, forHTTPHeaderField: "Content-Length")
                } catch let error as NSError {
                    print(error)
                }
            }
            else if contentType == Constants.CommonValues.urlencoded {
                if requestBody != nil {
                    jsonData = (requestBody as! String).data(using: .utf8)!
                }
                request.httpBody = jsonData
            }
        }
        return request
        
    }
    
    
    
    
    
    /**
     Synchronous request
     
     - parameter actionName:  action Name like Login
     - parameter httpMethod:  http methid like Get or Post
     - parameter requestBody: parameters with json format
     - parameter contentType: content type - json or urlencoded
     
     - returns: Object if success or error
     */
    static public func sendSynchronousRequestToServer(actionName : String,httpMethod : String, requestBody :AnyObject?, contentType : String ) -> AnyObject?{
        let request = self.getUrlRequest(urlString: actionName, httpMethod: httpMethod, requestBody: requestBody, contentType: contentType)
        let responseObject = self.getSessionWithContentType(contentType: contentType).requestSynchronousData(request: request)
        return self.getResponseData(responseData: responseObject.0, response: responseObject.1)
    }
    
    
    /**
     Asynchronous request
     
     - parameter actionName:        action Name like Login
     - parameter httpMethod:        http methid like Get or Post
     - parameter requestBody:       parameters with json format
     - parameter contentType:       ontent type - json or urlencoded
     - parameter completionHandler: completiontype Called after request was finished or failed
     */
    static public func sendAsynchronousRequestToServer(actionName:String, httpMethod:String, requestBody:AnyObject?, contentType:String, completionHandler: @escaping ((_ obj: AnyObject)->())){
        if Reachability()?.isReachable == true{
        // Store to refresh
        // UIApplication.shared.startNetworkActivity(info: "Fetching Data")
        let urlStr = actionName.replace(" ", with: "%20")
        let request = self.getUrlRequest(urlString: urlStr, httpMethod: httpMethod, requestBody: requestBody, contentType: contentType)
        request.timeoutInterval = 90
        let  postDataTask = self.getSessionWithContentType(contentType: contentType).dataTask(with: request as URLRequest) { (data, response, error) in
            if data == nil{
                completionHandler("error" as AnyObject)
                return
            }
        
//            guard (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]) != nil else{
//                completionHandler(AnyObject.self as AnyObject)
//                return
//            }
            completionHandler(self.getResponseData(responseData: data as NSData?, response: response)!)
        };
        postDataTask.resume()
        }else{
            let _ = UIAlertController(title: "Error", message:"No network available", defaultActionButtonTitle: "OK", tintColor: nil, handler: { (action) in
                
            }).show()
        }
    }
    
    
    
    /// Asynchrounu request with request completion
    ///
    /// - Parameters:
    ///   - actionName: action Name like Login
    ///   - httpMethod: http methid like Get or Post
    ///   - requestBody: http methid like Get or Post
    ///   - contentType: ontent type - json or urlencoded
    ///   - completionHandler: ontent type - json or urlencoded
    static public func sendAsynchronousRequestToServerWithURLCompletion(actionName:String, httpMethod:String, requestBody:AnyObject?, contentType:String, completionHandler: @escaping ((_ obj: AnyObject,_ requestUrl : URL)->())){
        if Reachability()?.isReachable == true{
            // Store to refresh
            // UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            let urlStr = actionName.replace(" ", with: "%20")
            let request = self.getUrlRequest(urlString: urlStr, httpMethod: httpMethod, requestBody: requestBody, contentType: contentType)
            let  postDataTask = self.getSessionWithContentType(contentType: contentType).dataTask(with: request as URLRequest) { (data, response, error) in
                if data == nil{
                    completionHandler("error" as AnyObject,request.url!)
                    return
                }
                
                //            guard (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]) != nil else{
                //                completionHandler(AnyObject.self as AnyObject)
                //                return
                //            }
                completionHandler(self.getResponseData(responseData: data as NSData?, response: response)!,request.url!)
            };
            postDataTask.resume()
        }else{
            let _ = UIAlertController(title: "Error", message:"No network available", defaultActionButtonTitle: "OK", tintColor: nil, handler: { (action) in
                
            }).show()
        }
    }
    
    static func getResponseData(responseData : NSData? , response: URLResponse?) -> AnyObject? {
        guard response != nil else{
            return "Your device is having poor or no connection to connect the server. Please check or reset your connection." as AnyObject?;
        }
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode
        let allHeaderFields : NSDictionary = (httpResponse?.allHeaderFields)! as NSDictionary
        
        //#-- Response is success
        if statusCode == 200 {
            //#-- Check respose is either JSON or XML or TEXT
            let contentType = allHeaderFields.value(forKey: "Content-Type") as? String
            if (contentType!.range(of:"application/json") != nil) {
                //#--  JSON
                var jsonResponse: AnyObject?
                do {
                    jsonResponse = try JSONSerialization.jsonObject(with: responseData! as Data, options: JSONSerialization.ReadingOptions()) as AnyObject
                } catch let jsonError {
                    print(jsonError)
                }
                return jsonResponse
            }
            else {
                //#-- Do part other values
                let responseStr  = NSString.init(data:responseData! as Data, encoding: String.Encoding.utf8.rawValue)
                return responseStr
                if (responseStr != nil)  {
                    let jsonResponse = self.json_StringToDictionary(jsonStr: responseStr as! String)
                    return jsonResponse
                }
            }
            
        }else{
            //#-- Response is failure case
            var jsonResponse : AnyObject?
            do {
                jsonResponse = try JSONSerialization.jsonObject(with: responseData! as Data, options: JSONSerialization.ReadingOptions()) as AnyObject
            } catch let jsonError {
                print(jsonError)
            }
            
            let  errorMessage  = (jsonResponse as? Dictionary<String, AnyObject>)?["message"] as? String
            if errorMessage != nil && errorMessage!.characters.count > 0 {
                return errorMessage as AnyObject?
            }
            else{
                return "Error while send request" as AnyObject?
            }
        }
        return "Error while send request" as AnyObject?
    }
    
    static func json_StringToDictionary(jsonStr:String) -> AnyObject {
        let objectData = jsonStr.data(using: String.Encoding.utf8)!
        var jsonResponse : AnyObject?
        do {
            jsonResponse = try JSONSerialization.jsonObject(with: objectData as Data, options: JSONSerialization.ReadingOptions()) as AnyObject
        } catch let jsonError {
            print(jsonError)
        }
        return jsonResponse!
    }
}

