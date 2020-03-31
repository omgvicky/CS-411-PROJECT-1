//
//  AppDelegate.swift
//  Starfit
//
//  Created by Cindy Quach and Victoria Tran on 3/29/20.
//  Copyright © 2020 Apple Developer. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //NAVIGATION BAR
        UINavigationBar.appearance().barTintColor =
            UIColor( red: 79.0/255.0, green: 245.0/255.0, blue: 212.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        let color = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
       let font = UIFont(name: "Roboto-Medium", size: 18)!
        
        let attributes: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): color,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): font
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attributes

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveStuff()
        
    }

    // Core Data
    lazy var pContainer: NSPersistentContainer = {

        let p_container = NSPersistentContainer(name: "Notes")
        p_container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("ERROR: \(error), \(error.userInfo)")
            }
        })
        return p_container
    }()

    // Saving Core Data
    func saveStuff () {
        let stuff = pContainer.viewContext
        if stuff.hasChanges {
            do {
                try stuff.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.pContainer.viewContext
