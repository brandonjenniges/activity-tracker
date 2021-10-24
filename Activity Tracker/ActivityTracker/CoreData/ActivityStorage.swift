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
    private let activityFetchController: NSFetchedResultsController<ActivitySession>
    
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
}

extension ActivityStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let activites = controller.fetchedObjects as? [ActivitySession] else { return }
        self.activites.value = activites
    }
}
