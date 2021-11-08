//
//  DBController.swift
//  CurrencyConversionIOSApp
//
//  Created by Mac mini on 11/7/21.
//

import Foundation
import UIKit
import CoreData

class DBController{
    
    static func saveCurrency(model:CurrencyModel) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: Constants.globalVariable.tableName, in: managedContext)!
        let user = NSManagedObject(entity: entity,insertInto: managedContext)
        
        user.setValue(model.currecyCode, forKeyPath: "currecyCode")
        user.setValue(model.from, forKeyPath: "from")
        user.setValue(model.to, forKeyPath: "to")
        user.setValue(model.currecyRate, forKeyPath: "currecyRate")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func getCurrency(currecyCode:String)-> CurrencyModel {
        
        let model = CurrencyModel()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.globalVariable.tableName)
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "currecyCode = %@", currecyCode)
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                var currecyCode = ""
                var from = ""
                var to = ""
                var currecyRate:Double = 0.0
                
                
                if let v_currecyCode = data.value(forKey: "currecyCode") as? String {
                    currecyCode = v_currecyCode
                }
                if let v_from = data.value(forKey: "from") as? String {
                    from = v_from
                }
                if let v_to = data.value(forKey: "to") as? String {
                    to = v_to
                }
                if let v_currecyRate = data.value(forKey: "currecyRate") as? Double {
                    currecyRate = v_currecyRate
                }
                
                model.currecyCode = currecyCode
                model.from = from
                model.to = to
                model.currecyRate = currecyRate
            }
            
        } catch {
            
            print("Failed")
        }
        
        return model
    }
    
    static func deleteCurrency(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.globalVariable.tableName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let arrUsrObj = try managedContext.fetch(fetchRequest)
            for usrObj in arrUsrObj as! [NSManagedObject] { // Fetching Object
                managedContext.delete(usrObj) // Deleting Object
            }
            try managedContext.save()
            
        } catch let error as NSError {
            print("error",error)
        }
    }
    
    static func isFetchData()-> Bool {
        var results: [NSManagedObject] = []
        do {
            let appDelegate =  UIApplication.shared.delegate as? AppDelegate;
            let managedContext = appDelegate!.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.globalVariable.tableName)
            results = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        print("count-->",results.count)
        return results.count > 0
    }
    
    
}
