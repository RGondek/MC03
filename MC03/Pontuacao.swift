//
//  Pontuacao.swift
//  MC03
//
//  Created by Lucas Leal Mendonça on 25/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import Foundation
import CoreData

class Pontuacao: NSManagedObject {

    @NSManaged var categoria: String
    @NSManaged var data: NSDate
    @NSManaged var pontos: NSNumber

}
