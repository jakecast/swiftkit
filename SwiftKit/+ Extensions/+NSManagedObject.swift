import CoreData

public extension NSManagedObject {
    class var entityName: String {
        var entityName = self
            .description()
            .componentsSeparatedByString(".")
            .lastItem()?
            .componentsSeparatedByString("_")
            .firstItem()
        return entityName ?? self.description()
    }
    
    var hasTemporaryID: Bool {
        return self.objectID.temporaryID
    }
    
    class func entityProperties(#context: NSManagedObjectContext) -> [NSPropertyDescription] {
        return self.entityDescription(context: context).properties as? [NSPropertyDescription] ?? []
    }
    
    class func entityDescription(#context: NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entityForName(self.entityName, inManagedObjectContext: context)!
    }
    
    class func createEntity(#context: NSManagedObjectContext, objectAttributes: [String:AnyObject]?=nil) -> Self {
        let newManagedObject = self(entity: self.entityDescription(context: context), insertIntoManagedObjectContext: context)
        if let attributes = objectAttributes {
            newManagedObject.update(attributes: attributes)
        }
        return newManagedObject
    }

    func obtainPermanentIdentifier() {
        if self.hasTemporaryID == true {
            self.debugOperation {(error) -> (Void) in
                self.managedObjectContext?.obtainPermanentIDsForObjects([self, ], error: error)
            }
        }
    }
    
    func update(#attributes: [String:AnyObject]) {
        self.setValuesForKeysWithDictionary(attributes)
    }
}