//
//  APIController.swift
//  Places Search DM
//
//  Created by Appinventiv on 21/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation

class APIController{
    func requestData(parameters: String,onJsonSuccess: ([DataModel])->Void){
        var dataModelObjects=[DataModel]()
        let searchKey = parameters.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchKey)&key=AIzaSyA6HrKIxM1hsGh7Sf0hZ1cabSA_5JXxXQ8"
        print(searchKey)
        if let url = URL(string: urlString) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                var arr=[String]()
                let resultsArray = json["results"]
                for places in resultsArray{
                    //print(places.1["name"])
                    //DataModel(
                    let typeArray = (places.1["types"].array)
                    arr.removeAll()
                    for types in typeArray!{
                        arr.append(types.stringValue)
                    }
                    let obj = DataModel(place_name: places.1["name"].stringValue, place_address: places.1["name"].stringValue, type: arr)
                    dataModelObjects.append(obj)
                }
                onJsonSuccess(dataModelObjects)
                    // we're OK to parse!
                
            }
        }
    }
}
