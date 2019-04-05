//
//  IconsManager.swift
//  wzp_challenge
//
//  Created by james on 14/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import RealmSwift
class IconsManager: NSObject {
    static let sharedInstance = IconsManager()

}

//MARK: - Get Icon
extension IconsManager {
    func getAllIcon() -> Array<Icon>{
        let realm = try! Realm()
        return Array(realm.objects(Icon.self))
    }
    func getIconBySearchText(_ text : String)-> Array<Icon>{
        let realm = try! Realm()
        let predicate = NSPredicate(format: "title CONTAINS[c] %@ or subtitle CONTAINS[c] %@ ", text, text )
        let results =  realm.objects(Icon.self).filter(predicate)
        return Array(results)
    }
}

//MARK: - Create Icon
extension IconsManager {
    func createOrUpdateObjects(objects: Array<NSDictionary> ) -> Array<Icon>{
        var r : Array<Icon> = []
        for item in objects {
            if  let e =   createOrUpdateObject(item) {
                r.append(e)
            }
        }
        return r
    }
    
    func createOrUpdateObject(_ object: NSDictionary) -> Icon?{
        let item = Icon()
        let realm = try! Realm()
        
        if let title = object.object(forKey: "title") as? String {
            item.title =  title
        }
        if let subtitle = object.object(forKey: "subtitle") as? String {
            item.subtitle =  subtitle
        }
        if let icon_url = object.object(forKey: "image") as? String {
            item.icon_url =  icon_url
        }
        try! realm.write {
            realm.add(item, update: true)
        }
        return item
    }
}
