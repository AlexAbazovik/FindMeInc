import Foundation
import Alamofire
import AlamofireImage

class UploadSession {
    class var sharedInfo: UploadSession {
        struct My {
            static var instance = UploadSession()
        }
        return My.instance
    }
    
    let serverURL: String = "http://104.238.176.105/"
    
    //MARK: Upload photo to the server
    func uploadPhoto(image: UIImage, uploadProgress progress:@escaping(_ response: Double) -> Void, onSuccess success:@escaping(_ response: Int) -> Void, onFailure failure: @escaping(_ error: Error) -> Void) {
        
        let uploadData = UIImagePNGRepresentation(image)
        Alamofire.upload(multipartFormData: { (multipartData) in
            multipartData.append(uploadData!, withName: "photoupload", fileName: "photoupload.png", mimeType: "image/png")
        }, to: "\(serverURL)/api/uploadphoto", method: .post) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (uploadProgress) in
                    //print("Upload Progress: \(uploadProgress.fractionCompleted)")
                    progress(uploadProgress.fractionCompleted)
                })
                upload.responseJSON { response in
                    success((response.result.value as! NSDictionary).value(forKey: "data") as! Int)
                }
                
            case .failure(let encodingError):
                print(encodingError)  
            }
        }
    }
    
    //Mark save consultation
    func saveConsultation(parameters: [String : Any], onSuccess success: @escaping (_ response: Bool) -> Void, onFailure failure: @escaping (_ error: Error) -> Void) {
        let params: Parameters = parameters
        Alamofire.request("\(serverURL)/api/createconsultation", method: .post, parameters: params).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.result.value)
                success(true)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
