//
//  ViewController.swift
//  DatePicker
//
//  Created by Justin Shulman on 11/20/16.
//  Copyright © 2016 JLS. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var dateButton: UIButton!
    
    let textFieldBlank = UITextField()
    let toolBar = UIToolbar()
    var yearBTN = UIBarButtonItem()
    
    var keyboardHeight: CGFloat = 260
    let screenWidth = UIScreen.main.bounds.size.width
    
    let calendar = NSCalendar.current
    
    let currentDate = NSDate()
    var currentDateComps: NSDateComponents!
    var setDate: Date!
    var setDateComps: NSDateComponents!
    
    let datePicker = UIDatePicker()



    @IBAction func dateButton(_ sender: UIButton) {
        textFieldBlank.becomeFirstResponder()
    }
    
    func keyboardWillShow(notification:NSNotification) {
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        keyboardHeight = keyboardRectangle.height
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDate = currentDate as Date!
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.frame = CGRect(x: 0, y: 0, width: screenWidth, height: (keyboardHeight-toolBar.frame.height-100))
        dateButton.addSubview(textFieldBlank)

        datePicker.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.setValue(false, forKey: "highlightsToday")
        datePicker.addTarget(self, action: #selector(dateSet), for: .valueChanged)
        datePicker.timeZone = NSTimeZone.local
        datePicker.minimumDate = currentDate as Date
        
        textFieldBlank.inputView = datePicker
        
        dateSet()
        
    }
    
    func dateSet() {
        setDate = datePicker.date
        setDateComps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: setDate as Date) as NSDateComponents!
        
        dateButton.setTitle("\(dateFormat(date: setDate as NSDate, dateStyle: .medium, timeStyle: .none))     \(dateFormat(date: setDate as NSDate, dateStyle: .none, timeStyle: .short))", for: .normal)
        
    }
    
    func yearSelected() {
        
        // years from current date
        let yearRangeLimit = 4
        
        var comps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: setDate.addingTimeInterval(60*60*24*365) as Date) as NSDateComponents

        currentDateComps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: currentDate as Date) as NSDateComponents!
        
        if (setDateComps.year - currentDateComps.year) < yearRangeLimit {
            comps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: setDate.addingTimeInterval(60*60*24*365) as Date) as NSDateComponents
            setDate = (calendar.date(from: comps as DateComponents) as NSDate!) as Date!
            
        } else {
            setDate = calendar.date(byAdding: .year, value: -yearRangeLimit, to: calendar.date(from: comps as DateComponents)!)
            
        }
        
        datePicker.date = setDate as Date
        dateSet()
        yearBTN.title = String(describing: setDateComps.year)
        
    }
    
    override var inputAccessoryView: UIView? {
        
        toolBar.barStyle = UIBarStyle.black
        toolBar.isTranslucent = false
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()

        yearBTN = UIBarButtonItem(title: String(calendar.component(.year, from: setDate as Date)), style: .plain, target: self, action: #selector(yearSelected))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        toolBar.setItems([yearBTN, spacer], animated: true)
        
        return toolBar
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

 
