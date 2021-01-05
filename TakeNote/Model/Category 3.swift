//
//  Category.swift
//  TakeNote
//
//  Created by Syimyk on 11/30/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import Foundation
import RealmSwift


class Category : Object{
    @objc dynamic var name : String = ""
    let notes = List<Note>()
}
