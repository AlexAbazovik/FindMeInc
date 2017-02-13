import Foundation

class MySession {
    class var sharedInfo: MySession {
        struct My {
            static var instance = MySession()
        }
        return My.instance
    }
    
    var tagsCollection = [String]()
}
