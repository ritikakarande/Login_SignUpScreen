//
//  EmployeeData+CoreDataProperties.swift
//  Sprint1
//
//  Created by Capgemini-DA087 on 8/25/22.
//
//

import Foundation
import CoreData


extension EmployeeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeData> {
        return NSFetchRequest<EmployeeData>(entityName: "EmployeeData")
    }

    @NSManaged public var empEmailId: String?
    @NSManaged public var empMobile: String?
    @NSManaged public var empName: String?
    @NSManaged public var empPassword: String?

}

extension EmployeeData : Identifiable {

}
