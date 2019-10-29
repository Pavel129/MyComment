//
//  Comment+CoreDataProperties.swift
//  MyComment
//
//  Created by Mac on 29/10/2019.
//  Copyright © 2019 Pavel CH.V. All rights reserved.
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var date: Date?
    @NSManaged public var nemsComment: String?

}
