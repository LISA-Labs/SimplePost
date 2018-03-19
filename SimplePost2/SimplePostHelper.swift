//
//  SimplePostHelper.swift
//  SimplePost2
//
//  Created by byongguen son on 2017. 12. 3..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit

extension UIView{
    func equalWidth(toView: UIView){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: toView, attribute: .width, multiplier: 1.0, constant: 0))
    }
    func equalHeight(toView: UIView){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: toView, attribute: .height, multiplier: 1.0, constant: 0))
    }
    func equalLeading(toView: UIView){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leading, multiplier: 1.0, constant: 0))
    }
    func equalTrailing(toView: UIView){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing, multiplier: 1.0, constant: 0))
    }
    func equalTop(toView: UIView){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .top, multiplier: 1.0, constant: 0))
    }
    func equalBottom(toView: UIView){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    func equalCenterX(toView: UIView){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: toView, attribute: .centerX, multiplier: 1.0, constant: 0))
    }
    func equalCenterY(toView: UIView){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .centerY, relatedBy: .equal, toItem: toView, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    func equalWidth(toView: UIView, constant: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: toView, attribute: .width, multiplier: 1.0, constant: constant))
    }
    func equalHeight(toView: UIView, constant: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: toView, attribute: .height, multiplier: 1.0, constant: constant))
    }
    func equalLeading(toView: UIView, constant: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leading, multiplier: 1.0, constant: constant))
    }
    func equalTrailing(toView: UIView, constant: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing, multiplier: 1.0, constant: constant))
    }
    func equalTop(toView: UIView, constant: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .top, multiplier: 1.0, constant: constant))
    }
    func equalBottom(toView: UIView, constant: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottom, multiplier: 1.0, constant: constant))
    }
    func equalCenterX(toView: UIView, constant: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: toView, attribute: .centerX, multiplier: 1.0, constant: constant))
    }
    func equalCenterY(toView: UIView, constant: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .centerY, relatedBy: .equal, toItem: toView, attribute: .centerY, multiplier: 1.0, constant: constant))
    }
    func equalWidth(toView: UIView, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: toView, attribute: .width, multiplier: multiplier, constant: 0))
    }
    func equalHeight(toView: UIView, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: toView, attribute: .height, multiplier: multiplier, constant: 0))
    }
    func equalLeading(toView: UIView, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leading, multiplier: multiplier, constant: 0))
    }
    func equalTrailing(toView: UIView, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing, multiplier: multiplier, constant: 0))
    }
    func equalTop(toView: UIView, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .top, multiplier: multiplier, constant: 0))
    }
    func equalBottom(toView: UIView, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottom, multiplier: multiplier, constant: 0))
    }
    func equalWidth(toView: UIView,constant: CGFloat, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: toView, attribute: .width, multiplier: multiplier, constant: constant))
    }
    func equalHeight(toView: UIView,constant: CGFloat, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: toView, attribute: .height, multiplier: multiplier, constant: constant))
    }
    func equalLeading(toView: UIView,constant: CGFloat, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leading, multiplier: multiplier, constant: constant))
    }
    func equalTrailing(toView: UIView,constant: CGFloat, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing, multiplier: multiplier, constant: constant))
    }
    func equalTop(toView: UIView,constant: CGFloat, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .top, multiplier: multiplier, constant: constant))
    }
    func equalBottom(toView: UIView,constant: CGFloat, multiplier: CGFloat){
        self.addConstraint(NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottom, multiplier: multiplier, constant: constant))
    }
}
