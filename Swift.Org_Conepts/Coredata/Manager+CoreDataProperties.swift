//
//  Manager+CoreDataProperties.swift
//  Swift.Org_Conepts
//
//  Created by Nagaraju on 17/11/24.
//
//

import Foundation
import CoreData


extension Manager {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Manager> {
        return NSFetchRequest<Manager>(entityName: "Manager")
    }

    @NSManaged public var department: String?
    @NSManaged public var empEmail: String?
    @NSManaged public var empId: Int64
    @NSManaged public var empName: String?

}

extension Manager : Identifiable {

}
