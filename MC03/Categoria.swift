//
//  Categoria.swift
//  MC03
//
//  Created by Rubens Gondek on 5/25/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import Foundation
import CoreData

class Categoria: NSManagedObject {

    @NSManaged var nome: String
    @NSManaged var palavras: NSSet

}
