import Foundation

class Data{
    class var sharedInfo: Data {
        struct My {
            static var instance = Data()
        }
        return My.instance
    }
    
    var tagsCollection = [String]()
    var states: NSDictionary?
    var dataCollectionForNewsFeed: NSArray?
    var chatInfo: NSDictionary?
    var iventDescription: NSDictionary?
}
