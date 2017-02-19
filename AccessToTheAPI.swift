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
    /*
        The user type is defined by the tag button is pressed during registration
        Existing types:
            0 - guest
            1 - user
            2 - freemium artist
            3 - freemium parlor
            --------------------
            20 - premium artist
            30 - premium parlor
                                                                                    */
    func registerNewUser(userName: String, emailAddress: String, password: String, referredBy: String? = nil, state: String? = nil, city: String? = nil, registerWithFacebook: Bool? = false, onSuccess success: @escaping (_ resObject: NSDictionary) -> Void, onFailure failure: @escaping (_ error: Error) -> Void){
        var params: Parameters = [
            "username": userName,
            "email": emailAddress,
            "password": password
        ]
        var userType:String = "user"
        //Depending on the type of user are added to the parameters passed to the server
        if registerWithFacebook == false{
            switch UserDefaults.standard.value(forKey: "userType") as! Int{
            case 2:
                userType = "artist"
                params["referred_by"] = referredBy
            case 3:
                userType = "parlor"
                params["state"] = state
                params["city"] = city
            default:
                break
            }
        }
                Alamofire.request("http://104.238.176.105/api/\(userType)/register", method: .post, parameters: params).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result{
            case .success:
                success(response.result.value as! NSDictionary)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    //MMARK: User login
    func loginUser(emailAddress: String, password: String, onSuccess success: @escaping (_ resObject: NSDictionary) -> Void, onFailure failure: @escaping (_ error: Error) -> Void){
        let parameters: Parameters = [
            "email": emailAddress,
            "password": password,
            ]
        Alamofire.request("http://104.238.176.105/api/login", method: .post, parameters: parameters).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result{
            case .success:
                success(response.result.value as! NSDictionary)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
