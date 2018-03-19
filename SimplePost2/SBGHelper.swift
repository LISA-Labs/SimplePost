//
//  SBGLayoutConstraint.swift
//  customAlertView
//
//  Created by byongguen son on 2017. 6. 28..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
protocol SPAddress{
    var postalField: String {get set}
    var addrField: String {get set}
}
let blueColor : UIColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1)
extension UIView{
    @available(iOS 9.0, *)
    func top(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0){
        self.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    @available(iOS 9.0, *)
    func left(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0){
        self.leftAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    @available(iOS 9.0, *)
    func right(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0){
        self.rightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    @available(iOS 9.0, *)
    func bottom(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0){
        self.bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    @available(iOS 9.0, *)
    func centerX(_ view: UIView, constant: CGFloat = 0){
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }
    @available(iOS 9.0, *)
    func centerY(_ view: UIView, constant: CGFloat = 0){
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
    @available(iOS 9.0, *)
    func width(_ anchor: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1){
        self.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant).isActive = true
    }
    @available(iOS 9.0, *)
    func height(_ anchor: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1){
        self.heightAnchor.constraint(equalTo: anchor,multiplier:multiplier, constant: constant).isActive = true
    }
    @available(iOS 9.0, *)
    func width(width: CGFloat)->NSLayoutConstraint{
        return self.widthAnchor.constraint(equalToConstant: width)
    }
    @available(iOS 9.0, *)
    func height(height: CGFloat)->NSLayoutConstraint{
        return self.heightAnchor.constraint(equalToConstant: height)
    }
    @available(iOS 9.0, *)
    func equal(_ view: UIView){
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
