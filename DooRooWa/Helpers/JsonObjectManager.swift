//
//  JsonObjectManager.swift
//  DooRooWa
//
//  Created by Vision on 15/03/23.
//

import Foundation

class JsonObjectManager {
   func toParameters<T:Encodable>(model: T?) -> [String:AnyObject]?  {
      if(model == nil) {
         return nil
      }
      
      let jsonData = modelToJson(model:model)
      let parameters = jsonToParameters(from: jsonData!)
      return parameters! as [String: AnyObject]
   }
   
   func modelToJson<T:Encodable>(model:T)  -> Data? {
      return try? JSONEncoder().encode(model.self)
   }
   
   func jsonToParameters(from data: Data) -> [String: Any]? {
      return try? (JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]) ?? [:]
   }
   
   /// Convert json to data
   /// - Parameter parms: json object
   func convertTOData(parms:[String:Any]) -> Data? {
      guard let data = try? JSONSerialization.data(withJSONObject: parms, options: []) else {
         return nil
      }
      return data
   }
}
