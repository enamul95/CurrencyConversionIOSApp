//
//  CurrencyModel.swift
//  CurrencyConversionIOSApp
//
//  Created by Mac mini on 11/7/21.
//

import Foundation

class CurrencyModel {
    var currecyCode: String = ""
    var from: String = ""
    var to:String = ""
    var currecyRate:Double = 0.00
    init(){}
    
    init(currecyCode : String, from: String,to:String,currecyRate:Double) {
        self.currecyCode = currecyCode
        self.from = from
        self.to = to
        self.currecyRate = currecyRate
        
    }
    
}
