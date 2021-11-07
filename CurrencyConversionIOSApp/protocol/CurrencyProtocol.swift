//
//  CurrencyProtocol.swift
//  CurrencyConversionIOSApp
//
//  Created by Enamul Haque on 7/11/21.
//

import Foundation

protocol CurrencyProtocol: class{
    func getCurrrency(currencyResponse:CurrencyResponse)
}

protocol ErrorProtocol: class {
    func error(errorFrom:String,error:LocalizedError)
}
