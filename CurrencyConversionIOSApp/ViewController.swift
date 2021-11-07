//
//  ViewController.swift
//  CurrencyConversionIOSApp
//
//  Created by Enamul Haque on 7/11/21.
//

import UIKit

class ViewController: UIViewController,CurrencyProtocol,ErrorProtocol {
  
    
    var currencyViewModel = CurrencyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyViewModel.currencyDelegate = self
        currencyViewModel.errorDelegate = self
        
        if(CheckNetwork.isOnline() == false){
            Custom_Sweet_alert.show_internet_connection()
        }else{
            getCurrrency()
        }
    }


    func getCurrrency(currencyResponse: CurrencyResponse) {
        Custom_Progress_bar.hide()
        print("success*******")
        print(currencyResponse.success)
        print(currencyResponse.quotes)
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

