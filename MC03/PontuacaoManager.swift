//
//  PontuacaoManager.swift
//  MC03
//
//  Created by Lucas Leal Mendonça on 26/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import CoreData

class PontuacaoManager {
    static let sharedInstance = PontuacaoManager()
    static let entityName = "Pontuacao"
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        return appDelegate.managedObjectContext!
        }()
    
    func newPontuacao() -> Pontuacao {
        return NSEntityDescription.insertNewObjectForEntityForName(PontuacaoManager.entityName, inManagedObjectContext: managedObjectContext) as! Pontuacao
    }
    
    func fetchPontuacoes() -> Array<Pontuacao> {
        let fetchRequest = NSFetchRequest(entityName: PontuacaoManager.entityName);
        var error: NSError?
        let fetchedResults = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject];
        
        if let results = fetchedResults as? [Pontuacao] {
            return results;
        } else {
            println("Error while fetching: \(error), \(error!.userInfo)");
        }
        
        return Array<Pontuacao>();
    }
    
    func save() {
        var error: NSError?;
        managedObjectContext.save(&error);
        
        if let e = error {
            println("Error while saving: \(error), \(error!.userInfo)");
        }
    }
    
    func fetchSortedPontuacoes() -> Array<Pontuacao> {
        let fetchRequest = NSFetchRequest(entityName: PontuacaoManager.entityName);
        
        var sortDescriptor = NSSortDescriptor(key: "pontos", ascending: false);
        var sortDescriptors = NSArray(object: sortDescriptor);
        fetchRequest.sortDescriptors = sortDescriptors as [AnyObject]
        
        var error: NSError?
        let fetchedResults = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject];
        
        if let results = fetchedResults as? [Pontuacao] {
            return results;
        } else {
            println("Error while fetching: \(error), \(error!.userInfo)");
        }
        
        return Array<Pontuacao>();
    }
}