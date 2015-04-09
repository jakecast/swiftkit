import UIKit

public extension NSNotificationCenter {
    class var defaultInstance: NSNotificationCenter {
        return self.defaultCenter()
    }
    
    class func addObserver(observer: AnyObject, selector aSelector: Selector, name aName: String?, object anObject: AnyObject?) {
        NSNotificationCenter
            .defaultCenter()
            .addObserver(observer, selector: aSelector, name: aName, object: anObject)
    }
    
    class func removeObserver(observer: AnyObject) {
        NSNotificationCenter
            .defaultCenter()
            .removeObserver(observer)
    }
    
    class func post(#notificationName: String, object: AnyObject?) {
        self.defaultInstance.post(notificationName: notificationName, object: object)
    }
    
    func post(#notificationName: String, object: AnyObject?) {
        self.post(
            notification: NSNotification(name: notificationName, object: object)
        )
    }
    
    func post(#notification: NSNotification) {
        self.postNotification(notification)
    }
    
    func add(#observer: AnyObject, selector: Selector, notificationName: String?, object: AnyObject?) -> Self {
        self.addObserver(observer, selector: selector, name: notificationName, object: object)
        return self
    }
    
    func remove(#observer: AnyObject) -> Self {
        self.removeObserver(observer)
        return self
    }
}