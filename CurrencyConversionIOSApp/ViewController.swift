//
//  ViewController.swift
//  CurrencyConversionIOSApp
//
//  Created by Enamul Haque on 7/11/21.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController,CurrencyProtocol,ErrorProtocol {
    
    
    var currencyViewModel = CurrencyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyViewModel.currencyDelegate = self
        currencyViewModel.errorDelegate = self
        
        if(CheckNetwork.isOnline() == false){
            Custom_Sweet_alert.show_internet_connection()
        }else{
          //  getCurrrency()
        }
        
       var model =  DBController.getCurrency(currecyCode: "USDBDT")
        print(model.currecyRate)
        print(model.currecyCode)
        print(model.from)
        print(model.to)
    }
    
    
    func getCurrrency(currencyResponse: CurrencyResponse) {
        Custom_Progress_bar.hide()
        
        for currency in currencyResponse.quotes!  {
            if(currency.key.count>3){
                self.saveCurrency(key: currency.key,value: currency.value)
            }
        }
        
    }
    
    func saveCurrency(key:String,value:Double){
        var model = CurrencyModel()
        let from:String = String(key.prefix(3))
        let to:String = String(key.suffix(3))
        model.currecyCode = key
        model.from = from
        model.to = to
        model.currecyRate = value
        DBController.saveCurrency(model: model)
    }
    
    func error(errorFrom: String, error: LocalizedError) {
        Custom_Progress_bar.hide()
    }
    
    func getCurrrency(){
        Custom_Progress_bar.show(view: self.view)
        let parameters: [String: Any] = [
            "access_key":Constants.globalVariable.access_key,
            "source":Constants.globalVariable.source,
            "format":Constants.globalVariable.format
        ]
        currencyViewModel.getCurrrency(var: parameters)
    }
    
}

