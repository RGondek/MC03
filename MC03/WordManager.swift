//
//  PalavraManager.swift
//  MC03
//
//  Created by Rubens Gondek on 5/18/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import CoreData

class WordManager {
    static let sharedInstance = WordManager()
    static let entityName = "Palavra"
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        return appDelegate.managedObjectContext!
        }()
    
    func newWord() -> Palavra {
        return NSEntityDescription.insertNewObjectForEntityForName(WordManager.entityName, inManagedObjectContext: managedObjectContext) as! Palavra;
    }
    
    func save() {
        var error: NSError?;
        managedObjectContext.save(&error);
        
        if let e = error {
            println("Error while saving: \(error), \(error!.userInfo)");
        }
    }
    
    func fetchWords() -> Array<Palavra> {
        let fetchRequest = NSFetchRequest(entityName: WordManager.entityName);
        var error: NSError?
        let fetchedResults = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject];
        
        if let results = fetchedResults as? [Palavra] {
            return results;
        } else {
            println("Error while fetching: \(error), \(error!.userInfo)");
        }
        
        return Array<Palavra>();
    }
    
    func fetchSortedWords() -> Array<Palavra> {
        let fetchRequest = NSFetchRequest(entityName: WordManager.entityName);
        
        var sortDescriptor = NSSortDescriptor(key: "word", ascending: true);
        var sortDescriptors = NSArray(object: sortDescriptor);
        fetchRequest.sortDescriptors = sortDescriptors as [AnyObject]
        
        var error: NSError?
        let fetchedResults = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject];
        
        if let results = fetchedResults as? [Palavra] {
            return results;
        } else {
            println("Error while fetching: \(error), \(error!.userInfo)");
        }
        
        return Array<Palavra>();
    }

}
