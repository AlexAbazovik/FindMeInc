import Foundation
import Alamofire

class MySession {
    class var sharedInfo: MySession {
        struct My {
            static var instance = MySession()
        }
        return My.instance
    }
    

    
    var token: String!
    
    // MARK: Start session
    //Not used yet
    func startSession(onSuccess success: @escaping (_ resObject: Any) -> Void, onFailure failure: @escaping (_ error: Error) -> Void){
        Alamofire.request("http://104.238.176.105/api/start").validate(statusCode: 200..<300).responseJSON(completionHandler: {
            response in
            switch response.result{
            case .success:
                self.token = ((response.result.value as! NSDictionary).object(forKey: "data") as! NSDictionary).object(forKey: "_token") as! String!
                success(response)
            case .failure(let error):
                failure(error)
            }
        })
    }
    //MARK: Get states
    func getState(onSuccess success: @escaping (_ resObject: NSDictionary) -> Void ,onFailure failure: @escaping (_ error: Error) -> Void){
        Alamofire.request("http://104.238.176.105/api/states").validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result{
            case .success:
                success((response.result.value as! NSDictionary).object(forKey: "data") as! NSDictionary)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    //MARK: Register new user
    func registerNewUser(userName: String, emailAddress: String, password: String, referredBy: String? = nil, state: String? = nil, city: String? = nil, onSuccess success: @escaping (_ resObject: NSDictionary) -> Void, onFailure failure: @escaping (_ error: Error) -> Void){
        var params: Parameters = [
            "username": userName,
            "email": emailAddress,
            "password": password
        ]
        switch UserDefaults.standard.value(forKey: "userType") as! String {
        case "artist":
            params["referred_by"] = referredBy
        default:
            break
        }
        Alamofire.request("http://104.238.176.105/api/\(UserDefaults.standard.value(forKey: "userType")!)/register", method: .post, parameters: params).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result{
            case .success:
                success(response.result.value as! NSDictionary)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    //MMARK: User login
    func loginUser(emailAddress: String = "UserTest2@test.com", password: String = "password", onSuccess success: @escaping (_ resObject: Any) -> Void, onFailure failure: @escaping (_ error: Error) -> Void){
        let parameters: Parameters = [
            "email": emailAddress,
            "password": password,
            ]
        Alamofire.request("http://104.238.176.105/api/login", method: .post, parameters: parameters).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result{
            case .success:
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
