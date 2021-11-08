//
//  Custom_Progress_bar.swift
//  CurrencyConversionIOSApp
//
//  Created by Enamul Haque on 7/11/21.
//

import Foundation
import PKHUD
class Custom_Progress_bar {
    
    static var progress_bar_time_out = 60
    static func showProgressDialog(){
        //HUD.show(.progress,onView: view)
        HUD.show(.progress)
        PKHUD.sharedHUD.hide(afterDelay: TimeInterval(progress_bar_time_out), completion: nil)
        
    }
    static func hide(){
        HUD.hide();
    }
    static func show(view:UIView){
        HUD.show(.progress,onView: view)
        PKHUD.sharedHUD.hide(afterDelay: TimeInterval(progress_bar_time_out), completion: nil)
    }
    
    
}
