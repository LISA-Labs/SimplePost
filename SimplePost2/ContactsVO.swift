//
//  ContactsVO.swift
//  SimplePost
//
//  Created by byongguen son on 2017. 6. 13..
//  Copyright © 2017년 byongguen. All rights reserved.
//

import Foundation
import Contacts
class ContactsVO{
    var contact : CNContact!
    var isSelected : Bool = false
    func getData() -> ContactData{
        let data = ContactData()
        let givenName = contact.givenName
        let familyName =  contact.familyName
        
        let name = "\(familyName)\(givenName)"
        var phone = ""
        if contact.phoneNumbers.count > 0{
            if let value = (contact.phoneNumbers[0].value).value(forKey: "digits") as? String{
                phone = value
            }
        }
        var postalCode = ""
        var address1 = ""
        var address2 = ""
        if contact.postalAddresses.count > 0{
            let address = contact.postalAddresses[0].value
            postalCode = address.value(forKey: "postalCode") as! String
            if let addr = address.value(forKey: "street") as? String{
                print(addr)
                let strArr = addr.components(separatedBy: "\n")
                if strArr.count > 1 {
                    address1 = strArr[0]
                    address2 = strArr[1]
                }else{
                    address1 = strArr[0]
                }
            }
        }
        data.name = name
        data.phone = phone
        data.postalCode = postalCode
        data.address = address1
        data.detail = address2
        return data
    }
}
class ContactData{
    var name: String?
    var phone: String?
    var postalCode: String?
    var address: String?
    var detail: String?
}
