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
                    //define as palavras para seedar
                    var cont = num
                    var palavrasSeedadas:NSMutableArray = NSMutableArray()
                    var arrPalavras = NSMutableArray(array: cat.palavras.allObjects)
                    while cont > 0 {
                        let rand = arc4random_uniform(UInt32(arrPalavras.count-1))
                        if (!palavrasSeedadas.containsObject(arrPalavras.objectAtIndex(Int(rand)))) {
                            palavrasSeedadas.addObject(arrPalavras.objectAtIndex(Int(rand)))
                            arrPalavras.removeObjectAtIndex(Int(rand))
                            cont--
                        }
                    }
                    return palavrasSeedadas
                }
            }
        } else {
            println("Error while fetching: \(error), \(error!.userInfo)");
        }
        
        return NSMutableArray();
    }
    
}
