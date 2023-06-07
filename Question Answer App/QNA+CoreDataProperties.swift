//
//  QNA+CoreDataProperties.swift
//  Question Answer App
//
//  Created by Dhiraj on 6/6/23.
//
//

import Foundation
import CoreData


extension QNA {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QNA> {
        return NSFetchRequest<QNA>(entityName: "QNA")
    }

    @NSManaged public var question: String?
    @NSManaged public var option1: String?
    @NSManaged public var option2: String?
    @NSManaged public var correctOption: String?

}

extension QNA : Identifiable {

}
