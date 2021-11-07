//
//  Custom_Sweet_alert.swift
//  CurrencyConversionIOSApp
//
//  Created by Enamul Haque on 7/11/21.
//

import Foundation

class Custom_Sweet_alert{
    
    
    static func show_error_message(messsage: String?){
        
        SweetAlert().showAlert("Attention!", subTitle: messsage, style: AlertStyle.warning)
        
    }
    
    static func show_internet_connection(){
        
        SweetAlert().showAlert("Internet Connection!", subTitle: "No Internet Connection !", style: AlertStyle.warning)
        
    }
    
    
}
