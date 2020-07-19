//
//  menuDataController.swift
//  mytest
//
//  Created by knuproimac on 2020-07-18.
//  Copyright © 2020 tony. All rights reserved.
//

import UIKit
import CoreData
class menuDataController: NSObject {
    var managedObjectContext: NSManagedObjectContext
    // MARK: - Init
        override init() {
            guard let modelURL = Bundle.main.url(forResource: "menu", withExtension:"momd")else {
                fatalError("Error loading model from bundle")
            }
            guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
                fatalError("Error initializing mom from: \(modelURL)")
            }
            let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
            managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            managedObjectContext.persistentStoreCoordinator = psc
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docURL = urls[urls.endIndex-1]
            let storeURL = docURL.appendingPathComponent("menu.sqlite")
            do {
                    try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            } catch {
                    fatalError("Error migrating store: \(error)")
            }
        }
// MARK: - add
    func insertOneMenu(_ item: ModelMenuItem?){
        guard let item = item else {
            return
        }
        let aMan = NSEntityDescription.insertNewObject(forEntityName: "QMenulist", into:managedObjectContext) as! QMenulist
        aMan.setValue(item.itemName, forKey: "itemName")
        aMan.setValue(item.groupID, forKey: "groupID")
        aMan.setValue(item.itemID, forKey: "itemID")
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    // MARK: - add group
    func insertOneGroup(_ item: ModelMenuGroup?){
        guard let item = item else {
            return
        }
        let aMan = NSEntityDescription.insertNewObject(forEntityName: "QMenuGroup", into:managedObjectContext) as! QMenuGroup
        aMan.setValue(item.name, forKey: "name")
        aMan.setValue(item.groupID, forKey: "groupID")
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
// MARK: - checking db is empaty
    func checkDBEmpty()->(Bool){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QMenulist")
        do {
            let searchResults = try self.managedObjectContext.fetch(fetchRequest)

            if(searchResults.count == 0){
                return true
            }
            
        } catch  {
            print(error)
        }
        return false
    }
// MARK: - delete
    func deleteOneMenu(_ item: ModelMenuItem?){
        guard let item = item else {
            return
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QMenulist")

        let searchResults = try? self.managedObjectContext.fetch(fetchRequest)
        let resultData = searchResults as! [QMenulist]
        for object in  resultData {

            if(item.itemID == Int(object.itemID) ){
                
                self.managedObjectContext.delete(object )
            }
        }
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    // MARK: - update
    func updateOneMenu(_ item: ModelMenuItem?){
        guard let item = item else {
            return
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QMenulist")

        let searchResults = try? self.managedObjectContext.fetch(fetchRequest)
        let resultData = searchResults as! [QMenulist]
        for object in  resultData {

            if(item.itemID == Int(object.itemID)){
                
                
                
                object.itemName = item.itemName
            }
        }
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
           
// MARK: - get menu list
    func getMenuItemList()->[ModelMenuItem]{
        var arr:[ModelMenuItem] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QMenulist")
        do {
            let searchResults = try self.managedObjectContext.fetch(fetchRequest)
            for p in (searchResults as! [NSManagedObject]){
              
                let name1 = p.value(forKey: "itemName")! as! String
                let id1 = p.value(forKey: "groupID")! as! Int
                let id2 = p.value(forKey: "itemID")! as! Int
                let item = ModelMenuItem()
                item.itemName = name1
                item.groupID = id1
                item.itemID = id2
                arr.append(item)
            }
        } catch  {
            print(error)
        }
        return arr
    }
    // MARK: - get menu list
    func getMenuGroupList()->[ModelMenuGroup]{
        var arr:[ModelMenuGroup] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QMenuGroup")
        do {
            let searchResults = try self.managedObjectContext.fetch(fetchRequest)
            for p in (searchResults as! [NSManagedObject]){
               // print("name:  \(p.value(forKey: "name")!) id: \(p.value(forKey: "id")!)")
                let name1 = p.value(forKey: "name")! as! String
                let gid = p.value(forKey: "groupID")! as! Int
               // let icon = p.value(forKey: "icon")! as! String
                let item = ModelMenuGroup()
                item.name = name1
                item.groupID = gid
                arr.append(item)
            }
        } catch  {
            print(error)
        }
        return arr
    }
        
    }
