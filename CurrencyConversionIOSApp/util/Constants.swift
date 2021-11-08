//
//  Constants.swift
//  CurrencyConversionIOSApp
//
//  Created by Enamul Haque on 7/11/21.
//

import Foundation
class Constants{
    struct globalVariable {
        static var refreshApiTime:Int = 10000//5 * 60 * 1000 //5 minutes
        static var access_key = "0b3471b49fd30569f3fe054d1a6dd38b"
        static var source = "USD"
        static var format = "1"
        static var tableName = "CURRENCY"
        static var refreshTime:Double = 60*30 //second
    }
}
