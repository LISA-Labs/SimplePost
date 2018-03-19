//
//  EditContactViewController.swift
//  simplePost
//
//  Created by byongguen son on 2017. 7. 30..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
import Contacts
class EditContactViewController: UIViewController,UITextFieldDelegate,SPAddress {
    var postalField: String{
        get{
            return self.postalCodeField.text ?? ""
        }
        set{
            self.postalCodeField.text = newValue
        }
    }
    var addrField: String {
        get{
            return self.addressField.text ?? ""
        }
        set{
            self.addressField.text = newValue
        }
    }
    let store = CNContactStore()
    @IBOutlet weak var navBar: MainNavigationView!
    
    @IBOutlet weak var familyNameField: UITextField!
    
    @IBOutlet weak var givenNameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var postalCodeField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    
    @IBOutlet weak var addressField: UITextField!
    
    var contact : CNMutableContact!
    let vo = ContactsVO()
    
    func initNavigationView() {
        self.navBar.setTitle(title: "\(contact.familyName)\(contact!.givenName)")
        self.navBar.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        self.navBar.setTitleColor(color: .white)
        self.navBar.setBGColor(color: UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        vo.contact = self.contact
        initNavigationView()
        self.navBar.leftButton.setImage(UIImage(named: "back"), for: .normal)
        self.navBar.leftButton.isHidden = false
        self.navBar.leftButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        prepareField()
        self.navBar.rightButton.setImage(UIImage(named: "check"), for: .normal)
        self.navBar.rightButton.isHidden = false
        self.navBar.rightButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        prepareField()
    }
    @objc
    func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    func prepareField(){
        vo.contact = self.contact
        familyNameField.delegate = self
        givenNameField.delegate = self
        phoneField.delegate = self
        postalCodeField.delegate = self
        addressField.delegate = self
        detailField.delegate = self
        
        familyNameField.text = contact.familyName
        givenNameField.text = contact.givenName
        phoneField.text = vo.getData().phone
        postalCodeField.text = vo.getData().postalCode
        addressField.text = vo.getData().address
        detailField.text = vo.getData().detail
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func handleSave() {
        guard let givenName = givenNameField.text else{
            return
        }
        guard let familyName = familyNameField.text else{
            return
        }
        guard let postalCode = postalCodeField.text else{
            return
        }
        guard let phoneNum = phoneField.text else{
            return
        }
        guard let address = addressField.text else {
            return
        }
        guard let detail = detailField.text else {
            return
        }
        let request = CNSaveRequest()
        
        let postalAddress = CNMutablePostalAddress()
        postalAddress.postalCode = postalCode
        postalAddress.street = "\(address)\n\(detail)"
        contact.givenName = givenName
        contact.familyName = familyName
        let contactPhone = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: phoneNum))
        contact.phoneNumbers = [contactPhone]
        let home = CNLabeledValue<CNPostalAddress>(label:CNLabelHome, value:postalAddress)
        contact.postalAddresses = [home]
        request.update(contact)
        try! store.execute(request)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchAddressButton(_ sender: Any) {
        let sb = UIStoryboard(name: "sender", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "searchAddress") as! SearchAddressViewController
        vc.ReturnController = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
