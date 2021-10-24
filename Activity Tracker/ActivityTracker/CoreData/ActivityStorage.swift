//
//  ActivityStorage.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/18/21.
//

import CoreData
import Combine

class ActivityStorage: NSObject, ObservableObject {
    
    var activites = CurrentValueSubject<[ActivitySession], Never>([])
    let activityFetchController: NSFetchedResultsController<ActivitySession>
    
    static let shared = ActivityStorage()
    
    private override init() {
        activityFetchController = NSFetchedResultsController(
            fetchRequest: ActivitySession.basicFetchRequest(),
            managedObjectContext: PersistenceContainer.shared.container.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        super.init()
        activityFetchController.delegate = self
        
        do {
            try activityFetchController.performFetch()
            activites.value = activityFetchController.fetchedObjects ?? []
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createActivityWith(type: ActivityType,
                                   reps: Int,
                                   date: Date,
                                   context: NSManagedObjectContext = PersistenceContainer.shared.container.viewContext) {
        let session = ActivitySession(context: context)
        session.type = type.rawValue
        session.reps = reps
        session.date = date
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    
    func deleteActivity(_ activity: ActivitySession) {
        let context = PersistenceContainer.shared.container.viewContext
        context.delete(activity)
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func updateActivityWith(session: ActivitySession,
                            type: ActivityType,
                                   reps: Int,
                                   date: Date,
                                   context: NSManagedObjectContext = PersistenceContainer.shared.container.viewContext) {
        session.type = type.rawValue
        session.reps = reps
        session.date = date
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

extension ActivityStorage: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let activites = controller.fetchedObjects as? [ActivitySession] else { return }
        self.activites.value = activites
    }
}
