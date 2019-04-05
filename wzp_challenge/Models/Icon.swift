//
//  Icon.swift
//  wzp_challenge
//
//  Created by james on 14/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import RealmSwift
class Icon: Object {
    @objc dynamic var title = ""
    @objc dynamic var subtitle = ""
    @objc dynamic var icon_url = ""
    override static func primaryKey() -> String? {
        return "icon_url"
    }
}
//MARK: - Extension Properties
extension Icon {
    var imageUrl: URL? { // read-only properties are automatically ignored
        return  URL(string: self.icon_url)
    }
}
