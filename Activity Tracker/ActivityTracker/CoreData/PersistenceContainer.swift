//
//  PersistenceContainer.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/18/21.
//

import CoreData

class PersistenceContainer {
    
    static var shared = PersistenceContainer()
    
    private init() {}
    
    lazy var container: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "ActivityTracker")
      container.loadPersistentStores { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()
}
