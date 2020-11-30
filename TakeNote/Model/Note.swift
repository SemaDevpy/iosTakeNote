//
//  Note.swift
//  TakeNote
//
//  Created by Syimyk on 11/30/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var body : String = ""
    var parentCategory = LinkingObjects(fromType : Category.self, property : "notes")
}
