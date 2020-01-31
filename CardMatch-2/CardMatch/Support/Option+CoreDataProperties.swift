//
//  Option+CoreDataProperties.swift
//  CardMatch
//
//  Created by Matthew Patterson on 10/1/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//
//

import Foundation
import CoreData


extension Option {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Option> {
        return NSFetchRequest<Option>(entityName: "Option")
    }

    @NSManaged public var scale: Int16

}
