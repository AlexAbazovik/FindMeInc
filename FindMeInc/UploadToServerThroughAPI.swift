import Foundation

class UploadSession {
    class var sharedInfo: UploadSession {
        struct My {
            static var instance = UploadSession()
        }
        return My.instance
    }
    
    
}
