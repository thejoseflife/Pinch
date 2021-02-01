//
//  AddItemController.swift
//  Pinch
//
//  Created by Josef Sajonz on 1/12/21.
//  Copyright © 2021 Josef Sajonz. All rights reserved.
//

import UIKit

class AddItemController: UIViewController {
    
    private let spacing: CGFloat = 20
    
    public var completion: ((Item) -> ())? = nil
    
    private var animatingRecurringPicker: Bool = false
    private var displayingRecurringPicker: Bool = false
    
    private var animatingIntervalPicker: Bool = false
    private var displayingIntervalPicker: Bool = false
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Title"
        label.textAlignment = .center
        label.font = UIFont(name: Global.FONT_BOLD, size: 20)
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter title"
        tf.backgroundColor = .systemBackground
        tf.font = UIFont(name: Global.FONT, size: 20)
        tf.autocorrectionType = .no
        tf.delegate = self
        return tf
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Price"
        label.textAlignment = .center
        label.font = UIFont(name: Global.FONT_BOLD, size: 20)
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    private lazy var priceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter price"
        tf.backgroundColor = .systemBackground
        tf.font = UIFont(name: Global.FONT, size: 20)
        tf.autocorrectionType = .no
        tf.delegate = self
        return tf
    }()
    
    private let recurringLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Repeat"
        label.font = UIFont(name: Global.FONT_BOLD, size: 20)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    private lazy var recurringButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleTappedRecurringButton), for: .touchUpInside)
        return button
    }()
    
    private let recurringButtonLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "None"
        label.font = UIFont(name: Global.FONT, size: 20)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingHead
        return label
    }()

    private let recurringPickerChoices = ["None", "Daily", "Weekly", "Monthly", "Yearly"]
    private var selectedRecurringChoice: Int = 0
    private let recurringPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private let intervalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Interval"
        label.font = UIFont(name: Global.FONT_BOLD, size: 20)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    private lazy var intervalButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleTappedIntervalButton), for: .touchUpInside)
        return button
    }()
    
    private let intervalButtonLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "None"
        label.font = UIFont(name: Global.FONT, size: 20)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingHead
        return label
    }()

    private let intervalPickerChoicesNone = ["None"]
    private let intervalPickerChoicesDaily = ["12:00 AM",
    "12:05 AM",
    "12:10 AM",
    "12:15 AM",
    "12:20 AM",
    "12:25 AM",
    "12:30 AM",
    "12:35 AM",
    "12:40 AM",
    "12:45 AM",
    "12:50 AM",
    "12:55 AM",
    "01:00 AM",
    "01:05 AM",
    "01:10 AM",
    "01:15 AM",
    "01:20 AM",
    "01:25 AM",
    "01:30 AM",
    "01:35 AM",
    "01:40 AM",
    "01:45 AM",
    "01:50 AM",
    "01:55 AM",
    "02:00 AM",
    "02:05 AM",
    "02:10 AM",
    "02:15 AM",
    "02:20 AM",
    "02:25 AM",
    "02:30 AM",
    "02:35 AM",
    "02:40 AM",
    "02:45 AM",
    "02:50 AM",
    "02:55 AM",
    "03:00 AM",
    "03:05 AM",
    "03:10 AM",
    "03:15 AM",
    "03:20 AM",
    "03:25 AM",
    "03:30 AM",
    "03:35 AM",
    "03:40 AM",
    "03:45 AM",
    "03:50 AM",
    "03:55 AM",
    "04:00 AM",
    "04:05 AM",
    "04:10 AM",
    "04:15 AM",
    "04:20 AM",
    "04:25 AM",
    "04:30 AM",
    "04:35 AM",
    "04:40 AM",
    "04:45 AM",
    "04:50 AM",
    "04:55 AM",
    "05:00 AM",
    "05:05 AM",
    "05:10 AM",
    "05:15 AM",
    "05:20 AM",
    "05:25 AM",
    "05:30 AM",
    "05:35 AM",
    "05:40 AM",
    "05:45 AM",
    "05:50 AM",
    "05:55 AM",
    "06:00 AM",
    "06:05 AM",
    "06:10 AM",
    "06:15 AM",
    "06:20 AM",
    "06:25 AM",
    "06:30 AM",
    "06:35 AM",
    "06:40 AM",
    "06:45 AM",
    "06:50 AM",
    "06:55 AM",
    "07:00 AM",
    "07:05 AM",
    "07:10 AM",
    "07:15 AM",
    "07:20 AM",
    "07:25 AM",
    "07:30 AM",
    "07:35 AM",
    "07:40 AM",
    "07:45 AM",
    "07:50 AM",
    "07:55 AM",
    "08:00 AM",
    "08:05 AM",
    "08:10 AM",
    "08:15 AM",
    "08:20 AM",
    "08:25 AM",
    "08:30 AM",
    "08:35 AM",
    "08:40 AM",
    "08:45 AM",
    "08:50 AM",
    "08:55 AM",
    "09:00 AM",
    "09:05 AM",
    "09:10 AM",
    "09:15 AM",
    "09:20 AM",
    "09:25 AM",
    "09:30 AM",
    "09:35 AM",
    "09:40 AM",
    "09:45 AM",
    "09:50 AM",
    "09:55 AM",
    "10:00 AM",
    "10:05 AM",
    "10:10 AM",
    "10:15 AM",
    "10:20 AM",
    "10:25 AM",
    "10:30 AM",
    "10:35 AM",
    "10:40 AM",
    "10:45 AM",
    "10:50 AM",
    "10:55 AM",
    "11:00 AM",
    "11:05 AM",
    "11:10 AM",
    "11:15 AM",
    "11:20 AM",
    "11:25 AM",
    "11:30 AM",
    "11:35 AM",
    "11:40 AM",
    "11:45 AM",
    "11:50 AM",
    "11:55 AM",
    "12:00 PM",
    "12:05 PM",
    "12:10 PM",
    "12:15 PM",
    "12:20 PM",
    "12:25 PM",
    "12:30 PM",
    "12:35 PM",
    "12:40 PM",
    "12:45 PM",
    "12:50 PM",
    "12:55 PM",
    "01:00 PM",
    "01:05 PM",
    "01:10 PM",
    "01:15 PM",
    "01:20 PM",
    "01:25 PM",
    "01:30 PM",
    "01:35 PM",
    "01:40 PM",
    "01:45 PM",
    "01:50 PM",
    "01:55 PM",
    "02:00 PM",
    "02:05 PM",
    "02:10 PM",
    "02:15 PM",
    "02:20 PM",
    "02:25 PM",
    "02:30 PM",
    "02:35 PM",
    "02:40 PM",
    "02:45 PM",
    "02:50 PM",
    "02:55 PM",
    "03:00 PM",
    "03:05 PM",
    "03:10 PM",
    "03:15 PM",
    "03:20 PM",
    "03:25 PM",
    "03:30 PM",
    "03:35 PM",
    "03:40 PM",
    "03:45 PM",
    "03:50 PM",
    "03:55 PM",
    "04:00 PM",
    "04:05 PM",
    "04:10 PM",
    "04:15 PM",
    "04:20 PM",
    "04:25 PM",
    "04:30 PM",
    "04:35 PM",
    "04:40 PM",
    "04:45 PM",
    "04:50 PM",
    "04:55 PM",
    "05:00 PM",
    "05:05 PM",
    "05:10 PM",
    "05:15 PM",
    "05:20 PM",
    "05:25 PM",
    "05:30 PM",
    "05:35 PM",
    "05:40 PM",
    "05:45 PM",
    "05:50 PM",
    "05:55 PM",
    "06:00 PM",
    "06:05 PM",
    "06:10 PM",
    "06:15 PM",
    "06:20 PM",
    "06:25 PM",
    "06:30 PM",
    "06:35 PM",
    "06:40 PM",
    "06:45 PM",
    "06:50 PM",
    "06:55 PM",
    "07:00 PM",
    "07:05 PM",
    "07:10 PM",
    "07:15 PM",
    "07:20 PM",
    "07:25 PM",
    "07:30 PM",
    "07:35 PM",
    "07:40 PM",
    "07:45 PM",
    "07:50 PM",
    "07:55 PM",
    "08:00 PM",
    "08:05 PM",
    "08:10 PM",
    "08:15 PM",
    "08:20 PM",
    "08:25 PM",
    "08:30 PM",
    "08:35 PM",
    "08:40 PM",
    "08:45 PM",
    "08:50 PM",
    "08:55 PM",
    "09:00 PM",
    "09:05 PM",
    "09:10 PM",
    "09:15 PM",
    "09:20 PM",
    "09:25 PM",
    "09:30 PM",
    "09:35 PM",
    "09:40 PM",
    "09:45 PM",
    "09:50 PM",
    "09:55 PM",
    "10:00 PM",
    "10:05 PM",
    "10:10 PM",
    "10:15 PM",
    "10:20 PM",
    "10:25 PM",
    "10:30 PM",
    "10:35 PM",
    "10:40 PM",
    "10:45 PM",
    "10:50 PM",
    "10:55 PM",
    "11:00 PM",
    "11:05 PM",
    "11:10 PM",
    "11:15 PM",
    "11:20 PM",
    "11:25 PM",
    "11:30 PM",
    "11:35 PM",
    "11:40 PM",
    "11:45 PM",
    "11:50 PM",
    "11:55 PM"]
    
    private let intervalPickerChoicesWeekly = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    private let intervalPickerChoicesMonthly = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    private let intervalPickerChoicesYearly = ["None"]
    private var selectedIntervalChoice: Int = 0
    private let intervalPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
       
        let font = UIFont.boldSystemFont(ofSize: 20)
        let attributes = [NSAttributedString.Key.font: font]
        
        let createButton = UIButton(type: .system)
        createButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        let createText = "Create"
        let createAttributedText = NSAttributedString(string: createText, attributes: attributes)
        createButton.setAttributedTitle(createAttributedText, for: .normal)
        view.addSubview(createButton)
        createButton.frame = CGRect(x: view.width - createButton.intrinsicContentSize.width - 15, y: 10, width: createButton.intrinsicContentSize.width, height: createButton.intrinsicContentSize.height)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        let cancelText = "Cancel"
        let cancelAttributedText = NSAttributedString(string: cancelText, attributes: attributes)
        cancelButton.setAttributedTitle(cancelAttributedText, for: .normal)
        view.addSubview(cancelButton)
        cancelButton.frame = CGRect(x: 15, y: 10, width: cancelButton.intrinsicContentSize.width, height: cancelButton.intrinsicContentSize.height)
        
        let labelWidth: CGFloat = 80
        view.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 0, y: cancelButton.bottom + spacing, width: labelWidth, height: titleLabel.intrinsicContentSize.height)
        
        view.addSubview(titleTextField)
        titleTextField.frame = CGRect(x: titleLabel.right + 10, y: cancelButton.bottom + spacing, width: view.width - 20 - labelWidth, height: titleTextField.intrinsicContentSize.height)
        
        view.addSubview(priceLabel)
        priceLabel.frame = CGRect(x: 0, y: titleLabel.bottom + spacing, width: labelWidth, height: priceLabel.intrinsicContentSize.height)
        
        view.addSubview(priceTextField)
        priceTextField.frame = CGRect(x: priceLabel.right + 10, y: titleLabel.bottom + spacing, width: view.width - 20 - labelWidth, height: priceTextField.intrinsicContentSize.height)
        
        view.addSubview(recurringLabel)
        recurringLabel.frame = CGRect(x: 0, y: priceLabel.bottom + spacing, width: labelWidth, height: recurringLabel.intrinsicContentSize.height)
        
        view.addSubview(recurringButton)
        recurringButton.frame = CGRect(x: recurringLabel.right + 10, y: priceLabel.bottom + spacing, width: view.width - labelWidth - 20, height: recurringLabel.intrinsicContentSize.height)
        
        view.addSubview(recurringButtonLabel)
        recurringButtonLabel.frame = CGRect(x: recurringLabel.right + 10, y: priceLabel.bottom + spacing, width: view.width - labelWidth - 20, height: recurringLabel.intrinsicContentSize.height)
        
        view.addSubview(recurringPicker)
        recurringPicker.delegate = self
        recurringPicker.dataSource = self
        recurringPicker.frame = CGRect(x: 0, y: view.height, width: view.width, height: recurringPicker.intrinsicContentSize.height)
        
        view.addSubview(intervalLabel)
        intervalLabel.frame = CGRect(x: 0, y: recurringLabel.bottom + spacing, width: labelWidth, height: intervalLabel.intrinsicContentSize.height)
        
        view.addSubview(intervalButton)
        intervalButton.frame = CGRect(x: intervalLabel.right + 10, y: recurringLabel.bottom + spacing, width: view.width - labelWidth - 20, height: intervalLabel.intrinsicContentSize.height)
        
        view.addSubview(intervalButtonLabel)
        intervalButtonLabel.frame = CGRect(x: intervalLabel.right + 10, y: recurringLabel.bottom + spacing, width: view.width - labelWidth - 20, height: intervalLabel.intrinsicContentSize.height)
        
        view.addSubview(intervalPicker)
        intervalPicker.delegate = self
        intervalPicker.dataSource = self
        intervalPicker.frame = CGRect(x: 0, y: view.height, width: view.width, height: intervalPicker.intrinsicContentSize.height)
    }
    
    @objc private func handleAdd() {
        if let title = titleTextField.text, !title.isEmpty, let price = priceTextField.text, !price.isEmpty {
                
            DispatchQueue.main.async {
                
                if let priceDouble = Float(price) {
                    self.dismiss(animated: true, completion: {
                        let item = Item(title: title, price: priceDouble, recurring: self.selectedRecurringChoice, interval: self.selectedIntervalChoice, creationDate: Date().timeIntervalSince1970)
                        self.completion!(item)
                        
                    })
                } else {
                    let alert = UIAlertController(title: "Invalid price!", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
                
            }
            
        }
    }
    
    @objc private func handleCancel() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    private func presentRecurringPicker() {
        if !animatingRecurringPicker {
            self.animatingRecurringPicker = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.recurringPicker.frame = CGRect(x: 0, y: self.view.height - self.recurringPicker.intrinsicContentSize.height, width: self.view.width, height: self.recurringPicker.intrinsicContentSize.height)
            }, completion: { (result) in
                self.animatingRecurringPicker = false
                self.displayingRecurringPicker = true
            })
        }
    }
    
    private func dismissRecurringPicker() {
        if !animatingRecurringPicker {
            self.animatingRecurringPicker = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.recurringPicker.frame = CGRect(x: 0, y: self.view.height, width: self.view.width, height: self.recurringPicker.intrinsicContentSize.height)
            }, completion: { (result) in
                self.animatingRecurringPicker = false
                self.displayingRecurringPicker = false
            })
        }
    }
    
    private func presentIntervalPicker() {
        if !animatingIntervalPicker {
            self.animatingIntervalPicker = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.intervalPicker.frame = CGRect(x: 0, y: self.view.height - self.intervalPicker.intrinsicContentSize.height, width: self.view.width, height: self.intervalPicker.intrinsicContentSize.height)
            }, completion: { (result) in
                self.animatingIntervalPicker = false
                self.displayingIntervalPicker = true
            })
        }
    }
    
    private func dismissIntervalPicker() {
        if !animatingIntervalPicker {
            self.animatingIntervalPicker = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.intervalPicker.frame = CGRect(x: 0, y: self.view.height, width: self.view.width, height: self.intervalPicker.intrinsicContentSize.height)
            }, completion: { (result) in
                self.animatingIntervalPicker = false
                self.displayingIntervalPicker = false
            })
        }
    }
    
    @objc private func handleTappedRecurringButton() {
        if !displayingRecurringPicker {
            if displayingIntervalPicker {
                dismissIntervalPicker()
            }
            presentRecurringPicker()

        } else {
            dismissRecurringPicker()
        }
    }
    
    @objc private func handleTappedIntervalButton() {
        if !displayingIntervalPicker {
            if displayingRecurringPicker {
                dismissRecurringPicker()
            }
            presentIntervalPicker()
        } else {
            dismissIntervalPicker()
        }
    }
    
}

extension AddItemController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == priceTextField {
            let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            
            return string == numberFiltered
        }
        
        return true
    }
}

extension AddItemController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView == recurringPicker {
            return 1
        } else if pickerView == intervalPicker {
            return 1
        }
        
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == recurringPicker {
            return recurringPickerChoices.count
        } else if pickerView == intervalPicker {
            switch selectedRecurringChoice {
            case 0:
                return intervalPickerChoicesNone.count
            case 1:
                return intervalPickerChoicesDaily.count
            case 2:
                return intervalPickerChoicesWeekly.count
            case 3:
                return intervalPickerChoicesMonthly.count
            case 4:
                return intervalPickerChoicesYearly.count
            default:
                return intervalPickerChoicesNone.count
            }
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == recurringPicker {
            return recurringPickerChoices[row]
        } else if pickerView == intervalPicker {
            
            switch selectedRecurringChoice {
            case 0:
                return intervalPickerChoicesNone[row]
            case 1:
                return intervalPickerChoicesDaily[row]
            case 2:
                return intervalPickerChoicesWeekly[row]
            case 3:
                return intervalPickerChoicesMonthly[row]
            case 4:
                return intervalPickerChoicesYearly[row]
            default:
                return intervalPickerChoicesNone[row]
            }
        }

        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == recurringPicker {
            recurringButtonLabel.text = recurringPickerChoices[row]
            selectedRecurringChoice = row
            intervalPicker.reloadAllComponents()
        }
        
        if pickerView == intervalPicker {
            
            selectedIntervalChoice = row
            
            switch selectedRecurringChoice {
            case 0:
                intervalButtonLabel.text = intervalPickerChoicesNone[row]
                break
            case 1:
                intervalButtonLabel.text = intervalPickerChoicesDaily[row]
                break
            case 2:
                intervalButtonLabel.text = intervalPickerChoicesWeekly[row]
                break
            case 3:
                intervalButtonLabel.text = intervalPickerChoicesMonthly[row]
                break
            case 4:
                intervalButtonLabel.text = intervalPickerChoicesYearly[row]
                break
            default:
                intervalButtonLabel.text = intervalPickerChoicesNone[row]
                break
            }
            
            
            
        }
        
    }

}
