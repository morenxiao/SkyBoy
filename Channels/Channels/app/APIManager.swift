//
//  APIManager.swift
//  Channels
//
//  Created by Calvin on 15/05/2017.
//  Copyright © 2017 rmo. All rights reserved.
//

import Alamofire

struct ApiManager {
  func get(url: String, completionHandler: @escaping (DataResponse<Any>) -> Void) {
    
    var request = URLRequest(url: NSURL(string: url) as! URL)
    
    request.timeoutInterval = 4 // 10 secs
    Alamofire.request(request).responseJSON { response in
      completionHandler(response)
    }
  }
}
