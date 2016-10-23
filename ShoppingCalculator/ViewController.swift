//
//  ViewController.swift
//  ShoppingCalculator
//
//  Created by Carol Han on 9/11/16.
//  Copyright © 2016 Carol Han. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var priceField: UITextField!
    
    @IBOutlet var discountField: UITextField!
    
    @IBOutlet var taxField: UITextField!
    
    @IBOutlet var finalPrice: UILabel!
    
    var price = ""
    var discount = ""
    var tax = ""

    
    func valid(input:String) -> Bool {
        //a function that test if an input is numeric and positive
        if NSNumberFormatter().numberFromString(input) != nil {
            if Double(input) >= 0{
                return true
            }
        }
        return false
    }
    
    
    func calculate() -> String {
        //a function that calculates and changes the color of output
        
        if (valid(price) && valid(discount) && valid(tax)){
            //test if inputs are valid,then calculate
            
            let priceNum = Double(price)
            let discountNum = Double(discount)
            let taxNum = Double(tax)
            
            if discountNum>100 {
                //I've never seen a discount like this
                finalPrice.textColor = UIColor.orangeColor()
                return "Oh man, this is charity!!!"
            }
            
            let result = String(format: "%.2f", priceNum! * (1-discountNum!/100) * (1+taxNum!/100))
            finalPrice.textColor = UIColor.blueColor()
            return "$"+result
            
        } else {
            
            finalPrice.textColor = UIColor.redColor()
            return "Please insert valid numbers!"
        }
    }
    
    
    @IBAction func itemPrice(sender: UITextField) {
        //on change of price do calculate()
        price = priceField.text!
        finalPrice.text = calculate()
    }

    @IBAction func discountRate(sender: UITextField) {
        //on change of discount do calculate()
        discount = discountField.text!
        finalPrice.text = calculate()
    }
    
    @IBAction func taxRate(sender: UITextField) {
        //on change of tax do calculate()
        tax = taxField.text!
        finalPrice.text = calculate()
    }

    
    @IBOutlet var dateField: UIDatePicker!
    
    @IBOutlet var message: UILabel!
    
    @IBAction func ExpirationDate(sender: UIDatePicker) {
        //on change of Expiration Date counts the days left,and output in different colors
        
        var current = NSDate()
        //Formulate, since we only count to days
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        current = dateFormatter.dateFromString(dateFormatter.stringFromDate(current))!
        
        let expire = dateField.date
        
        let earlier = current.earlierDate(expire)
        let later = current.laterDate(expire)
        
        if current == earlier{
            let difference = NSCalendar.currentCalendar().components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: earlier, toDate: later, options: NSCalendarOptions.init(rawValue: 0))
            message.text = "Expires in \(difference.year) years,\(difference.month) months, \(difference.day) days."
            message.textColor = UIColor.blueColor()
        }else{
            message.text = "Item already expired!"
            message.textColor = UIColor.redColor()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

