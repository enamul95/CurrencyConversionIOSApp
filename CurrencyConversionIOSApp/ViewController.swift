//
//  ViewController.swift
//  CurrencyConversionIOSApp
//
//  Created by Enamul Haque on 7/11/21.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,CurrencyProtocol,ErrorProtocol,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var dpCurrency: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lbConversionAmount: UILabel!
    var currencyViewModel = CurrencyViewModel()
    
    var pickerArray = ["USD","AED","AFN","CAD","BDT","EUR","HKD","ISK","PHP","DKK","HUF","CZK","AUD","RON","SEK","IDR","INR","BRL","RUB","HRK","JPY","THB","CHF","SGD","PLN","BGN","CNY","NOK","NZD","ZAR","USD","MXN","ILS","GBP","KRW","MYR"]
    
    var selectedRow = 0;
    let picker = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        currencyViewModel.currencyDelegate = self
        currencyViewModel.errorDelegate = self
        
        picker.delegate = self
        picker.dataSource = self
        dpCurrency.inputView = picker
        
        if(CheckNetwork.isOnline() == false){
            Custom_Sweet_alert.show_internet_connection()
        }else{
            if(DBController.isFetchData() == false){
                getCurrrency()
            }
        }
      
        dpCurrency.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        let image = UIImage(named: "arrow")
        imageView.image = image
        dpCurrency.rightView = imageView
        pickerDoneButton()
        
        Timer.scheduledTimer(timeInterval:TimeInterval(Constants.globalVariable.refreshTime), target: self, selector: #selector(ViewController.refreshApi), userInfo: nil, repeats: true)
    }
    
    @objc func refreshApi()
    {
        print("refresh api")
        if(CheckNetwork.isOnline() == false){
            Custom_Sweet_alert.show_internet_connection()
        }else{
            getCurrrency()
        }
    }
    
    //begin Picker view
    
    public func numberOfComponents(in pickerView:  UIPickerView) -> Int  {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row;
    }
    
    func pickerDoneButton(){
        
        let pickerView = picker
        pickerView.backgroundColor = .white
        pickerView.showsSelectionIndicator = true
        
        var toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: "canclePicker")
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        dpCurrency.inputView = pickerView
        dpCurrency.inputAccessoryView = toolBar
    }
    
    
    @objc func donePicker() {
        self.dpCurrency.text = pickerArray[selectedRow]
        dpCurrency.resignFirstResponder()
        
    }
    
    @objc  func canclePicker() {
        dpCurrency.resignFirstResponder()
    }
    
    //end picker view
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pickerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.lbCurrency.text = pickerArray[indexPath.row] as! String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var conversiontCurrency = pickerArray[indexPath.row]
        
        if(txtAmount.text! == ""){
            Custom_Sweet_alert.showWarning(messsage: "Please Enter Amount")
        }else if(dpCurrency.text == ""){
            Custom_Sweet_alert.showWarning(messsage: "Please Select Currency")
        }else{
            self.calcuateCurrency(conversiontCurrency:conversiontCurrency)
        }
    }
    func calcuateCurrency(conversiontCurrency:String){
        let currencyCode = dpCurrency.text!+conversiontCurrency
        let model =  DBController.getCurrency(currecyCode:currencyCode)
        let amount = Double(txtAmount.text!)
        let conversionAmout = amount!*model.currecyRate
        let conversionAmoutString = String(format: "$%.02f", conversionAmout)
        lbConversionAmount.text = conversionAmoutString
        
    }
    
    func saveCurrency(key:String,value:Double){
        
        let model = CurrencyModel()
        let from:String = String(key.prefix(3))
        let to:String = String(key.suffix(3))
        model.currecyCode = key
        model.from = from
        model.to = to
        model.currecyRate = value
        DBController.saveCurrency(model: model)
    }
    
    
    func getCurrrency(currencyResponse: CurrencyResponse) {
        Custom_Progress_bar.hide()
        DBController.deleteCurrency()
        for currency in currencyResponse.quotes!  {
            if(currency.key.count>3){
                self.saveCurrency(key: currency.key,value: currency.value)
            }
        }
        
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

