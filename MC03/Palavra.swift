//
//  Palavra.swift
//  MC03
//
//  Created by Rubens Gondek on 5/25/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import Foundation
import CoreData

class Palavra: NSManagedObject {

    @NSManaged var known: NSNumber
    @NSManaged var prompt: String
    @NSManaged var promptUS: String
    @NSManaged var translate: String
    @NSManaged var word: String
    @NSManaged var categoria: Categoria

}
