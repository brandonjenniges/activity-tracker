//
//  AppDelegate.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import Foundation
import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let mainViewController = HomeViewController()
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: - Core Data Stack -
    lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "ActivityTracker")
      container.loadPersistentStores { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()
}
