//
//  NetworkManager.swift
//  wzp_challenge
//
//  Created by james on 14/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import Alamofire
class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
}
//MARK: - REQUESTS
extension NetworkManager {
    func getListIcons (success: @escaping (Array<Icon>) -> Void, failed: @escaping () -> Void){
          Alamofire.request( Api.getIcons, method: .get ,parameters: nil ,encoding: URLEncoding.default).responseJSON { response in
            if  let json = response.result.value  as? NSDictionary, let icons =  json.object(forKey: "icons") as? Array<NSDictionary> {//success
                let items =  IconsManager.sharedInstance.createOrUpdateObjects(objects: icons )
                success(items)
             }else{
                failed()
            }
        }
        
    }
}
