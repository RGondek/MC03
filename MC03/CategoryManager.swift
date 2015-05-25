//
//  CategoryManager.swift
//  MC03
//
//  Created by Rubens Gondek on 5/18/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import CoreData

class CategoryManager {
    static let sharedInstance = CategoryManager()
    static let entityName = "Categoria"
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        return appDelegate.managedObjectContext!
        }()
    
    func newCategory() -> Categoria {
        return NSEntityDescription.insertNewObjectForEntityForName(CategoryManager.entityName, inManagedObjectContext: managedObjectContext) as! Categoria;
    }
    
    func save() {
        var error: NSError?;
        managedObjectContext.save(&error);
        
        if let e = error {
            println("Error while saving: \(error), \(error!.userInfo)");
        }
    }
    
    func fetchCategories() -> Array<Categoria> {
        let fetchRequest = NSFetchRequest(entityName: CategoryManager.entityName);
        var error: NSError?
        let fetchedResults = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject];
        
        if let results = fetchedResults as? [Categoria] {
            return results;
        } else {
            println("Error while fetching: \(error), \(error!.userInfo)");
        }
        
        return Array<Categoria>();
    }
    
    func fetchWordsForCategory(num:Int, categoryName:String) -> NSMutableArray {
        let fetchRequest = NSFetchRequest(entityName: CategoryManager.entityName);
        var error: NSError?
        let fetchedResults = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject];
        
        if let results = fetchedResults as? [Categoria] {
            for cat in results{
                if cat.nome == categoryName {
                    var words = NSMutableArray(array: cat.palavras.allObjects)
                    return NSMutableArray(array: words.subarrayWithRange(NSMakeRange(0, num)))
                }
            }
        } else {
            println("Error while fetching: \(error), \(error!.userInfo)");
        }
        
        return NSMutableArray();
    }
    
}
