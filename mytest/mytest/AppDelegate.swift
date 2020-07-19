//
//  AppDelegate.swift
//  mytest
//
//  Created by knuproimac on 2020-07-17.
//  Copyright © 2020 tony. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

     var lcontext:NSManagedObjectContext!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       // self.lcontext = self.persistentContainer.viewContext
        openDatabseMenu();
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "mytest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    func sharedInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    // MARK: - other functions

    func openDatabseMenu()
    {
        
        let controller =  menuDataController()
        let bre = controller.checkDBEmpty()
        if(bre ==  true){
            
            FakeData(controller)
        }
        
    }
    func FakeData(_ cv:menuDataController){
          let item1 =  ModelMenuItem.init()
           item1.groupID = 0
           item1.itemID = 1231
           item1.itemName = "apple pine $10.00"
           let item2 =  ModelMenuItem.init()
           item2.groupID = 0
           item2.itemID = 1232
           item2.itemName = "Casual Dining $18.00"
    
           let item3 =  ModelMenuItem.init()
           item3.groupID = 0
           item3.itemID = 1233
           item3.itemName = "Fast Food $18.00"
           let item4 =  ModelMenuItem.init()
           item4.groupID = 0
           item4.itemID = 1234
           item4.itemName = "Fine Dining $10.00"
           let item5 =  ModelMenuItem.init()
           item5.groupID = 0
           item5.itemID = 1235
           item5.itemName = "Delivery $10.00"
           let item6 =  ModelMenuItem.init()
           item6.groupID = 0
           item6.itemID = 1236
           item6.itemName = "Make at Home $1.00"
           let item12 =  ModelMenuItem.init()
           item12.groupID = 1
           item12.itemID = 1211
           item12.itemName = "beef $156.00"
           let item13 =  ModelMenuItem.init()
           item13.groupID = 1
           item13.itemID = 1212
           item13.itemName = "pork $122.00"
           let arrlistOne  = [item1, item2, item3, item4, item5, item6 ,item12,item13]
            for ite in arrlistOne{
                cv.insertOneMenu(ite)
            }
           let g1 =  ModelMenuGroup.init()
           g1.groupID = 0
           g1.name = "dishes"
           let g2 =  ModelMenuGroup.init()
           g2.groupID = 1
           g2.name = "raw food"
           let arrlistTwo = [g1, g2]
            for ite in arrlistTwo{
                cv.insertOneGroup(ite)
            }
 
           
           
       }


}

