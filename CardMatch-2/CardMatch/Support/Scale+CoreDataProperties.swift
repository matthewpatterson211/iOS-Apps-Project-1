//
//  Scale+CoreDataProperties.swift
//  CardMatch
//
//  Created by Matthew Patterson on 10/1/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedScale {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedScale> {
        return NSFetchRequest<SavedScale>(entityName: "SavedScale")
    }

    @NSManaged public var scale: Int16

}
