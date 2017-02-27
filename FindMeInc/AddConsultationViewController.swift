//
//  AddConsultationViewController.swift
//  FindMeInc
//
//  Created by Alex Vecher on 27.02.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class AddConsultationViewController: UIViewController {
    
    var currentDate: Date!

    @IBOutlet var borderViews: [UIView]!
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var clientTextField: UITextField!
    @IBOutlet weak var parlorTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    var datePicker: UIDatePicker!
    var invisibleTextField: UITextField!
    
    //MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBorder()
        setDate(currentDate)
        invisibleTextField = UITextField()
        self.view .addSubview(invisibleTextField)
        datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: 200.0))
        datePicker.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        datePicker.datePickerMode = .date
        datePicker.minimumDate = NSDate().addingTimeInterval(86400) as Date
        
        //Add toolbar to control the picker view
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = #colorLiteral(red: 0.8980392157, green: 0.6156862745, blue: 0.3803921569, alpha: 1)
        toolBar.sizeToFit()
        
        //Add buttons to the toolbar
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        cancelButton.tag = 1
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        invisibleTextField.inputAccessoryView = datePicker
        invisibleTextField.inputView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIToolbar actions
    func donePicker(_ sender: UIBarButtonItem) -> Void {
        if sender.tag != 1 {
            setDate(datePicker.date)
        }
        invisibleTextField.resignFirstResponder()
    }
    
    //MARK: - UIView borderViews
    func setBorder() -> Void {
        let colorConstant:Float = 255.0
        for view in borderViews {
            view.layer.borderWidth = 2.0
            view.layer.borderColor = UIColor.init(colorLiteralRed: 147.0 / colorConstant, green: 149.0 / colorConstant, blue: 152.0 / colorConstant, alpha: 1.0).cgColor
        }
    }
    
    //MARK: - Date
    func stringFromDateWithDateFormat(_ format: String, _ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func setDate(_ date: Date) -> Void {
        monthLabel.text = stringFromDateWithDateFormat("MMM", date).uppercased()
        dayLabel.text = stringFromDateWithDateFormat("dd", date)
        yearLabel.text = stringFromDateWithDateFormat("YY", date)
    }
    
    //MARK: - Actions
    @IBAction func actionArrowDownButton(_ sender: UIButton) {
        invisibleTextField.becomeFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
