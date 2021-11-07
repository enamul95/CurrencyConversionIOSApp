//
//  CurrencyViewModel.swift
//  CurrencyConversionIOSApp
//
//  Created by Enamul Haque on 7/11/21.
//

import Foundation
import UIKit
import Alamofire

class CurrencyViewModel{
    
    weak var errorDelegate: ErrorProtocol?
    weak var currencyDelegate: CurrencyProtocol?
    
    func getCurrrency(`var` parameters: [String: Any]){
        
        AF.request(IpConfig.getIP()+"live", method: .get, parameters:parameters).responseJSON { response in
            
            if let data = response.data {
                do{
                    let resposne = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                    print("resposne-->",resposne)
                    self.currencyDelegate?.getCurrrency(currencyResponse: resposne)
                    
                    
                }catch let err{
                    //  let error =
                    self.errorDelegate?.error(errorFrom: "Currecy Response",error: err as! LocalizedError)
                    print("error-->Currecy Response"+err.localizedDescription)
                }
            }
        }
    }
}
