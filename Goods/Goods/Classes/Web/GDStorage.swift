//
//  GDStorage.swift
//  Goods
//
//  Created by nabanita on 15/03/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit
import CoreData

class GDStorage: NSObject {
    
    var moc: NSManagedObjectContext?
    var inMemoryMoc: NSManagedObjectContext?
    var persistantStoreCoordinator: NSPersistentStoreCoordinator?
    var managedObjectModel: NSManagedObjectModel?
    
    static let sharedStorage: GDStorage = {
        let instance = GDStorage()
        return instance
    }()
    
    private override init() {
        
    }
    
    private func applicationDocumentDirectory() -> URL {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last!
    }
    
    func startCoreDataStack() {
        
        let path = Bundle.main.path(forResource: "GDDataModel", ofType: "momd")
        let momUrl = URL(fileURLWithPath: path!)
        
        self.managedObjectModel = NSManagedObjectModel.init(contentsOf: momUrl)
        self.persistantStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel!)
        
        let storeURL = self.applicationDocumentDirectory().appendingPathComponent("database.sqlite")
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        let persistantStore = try? (self.persistantStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options))
        
        if persistantStore != nil {
            
            self.moc = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
            self.moc?.persistentStoreCoordinator = self.persistantStoreCoordinator
            
            self.inMemoryMoc = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
            self.inMemoryMoc?.persistentStoreCoordinator = self.persistantStoreCoordinator
        }
        else {
            print("Counldn't create persistance store!")
        }
        
    }

}

extension GDStorage{
    
    //MARK: Core data helper extension
    
    func deleteEntityFromDBEntityName(_ entityName : String){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.includesPropertyValues = false
        
        self.moc?.performAndWait({
            
            do{
                let objects = try? (self.moc?.fetch(request))! as! [NSManagedObject]
                
                if let objects = objects{
                    for obj in objects{
                        self.moc?.delete(obj)
                    }
                }
            }
            catch let exception{
                print("deleteEntityFromDBEntityName exception = \(exception)")
            }
        })
        
        GDStorage.sharedStorage.saveMOCToStorage()
        
    }
    
    
    
    func deleteEntitiesFromDBEntityName(_ entityName : String, entities : [NSManagedObject]?){
        
        guard entities != nil else{
            return
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        self.moc?.performAndWait({
            
            do{
                let objects = try? (self.moc?.fetch(request))! as! [NSManagedObject]
                
                if let objects = objects{
                    for obj in objects{
                        if entities!.contains(obj) == true{
                            self.moc?.delete(obj)
                        }
                    }
                }
            }
            catch let exception{
                print("deleteEntityFromDBEntityName exception = \(exception)")
            }
        })
        
        GDStorage.sharedStorage.saveMOCToStorage()
    }
    
    
    func saveMOCToStorage(){
        
        weak var context : NSManagedObjectContext? = moc
        
        while(context != nil){
            
            context?.performAndWait({
                
                do{
                    try context?.save()
                }
                catch let exception{
                    print("saveMOCToStorage exception = \(exception)")
                }
                
                
            })
            context = context?.parent
            
        }
        
    }
    
    
    func deleteAllEntitiesFromDB() {
        
    }
    
}
