//
//  QRAlertView.swift
//  SimplePost
//
//  Created by byongguen son on 2017. 6. 27..
//  Copyright © 2017년 byongguen. All rights reserved.
//

import UIKit
class QRAlertView : UIView{
    
    lazy var infoContainerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var infoContainerViewHeightConstraint: NSLayoutConstraint!
    lazy var alertContainerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.9
        return view
    }()
    lazy var titleView : UIView = {
        let view = UIView()
        view.backgroundColor = blueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    lazy var QRImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    lazy var phoneLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    lazy var addressLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    lazy var seperatorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    lazy var nextButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
        button.setTitleColor(blueColor, for: .normal)
        return button
    }()
    
    var alertContainerViewHeightConstraint: NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.addSubview(alertContainerView)
        
        setupAlertContainerView()
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    
    func setupAlertContainerView(){
        alertContainerView.equalCenterX(toView: self)
        alertContainerView.equalCenterY(toView: self)
        alertContainerView.equalWidth(toView: self, multiplier: 0.8)
        alertContainerViewHeightConstraint = alertContainerView.heightAnchor.constraint(equalToConstant: 150)
        alertContainerViewHeightConstraint?.priority = 90
        alertContainerViewHeightConstraint?.isActive = true
        alertContainerView.addSubview(infoContainerView)
        alertContainerView.addSubview(titleView)
        alertContainerView.addSubview(QRImageView)
        alertContainerView.addSubview(nameLabel)
        alertContainerView.addSubview(phoneLabel)
        alertContainerView.addSubview(addressLabel)
        alertContainerView.addSubview(seperatorView)
        alertContainerView.addSubview(nextButton)
        setupInfoContainerView()
        setupTitleView()
        setupQRImageView()
        setupNameLabel()
        setupPhoneLabel()
        setupAddressLabel()
        setupSeperatorView()
        setupNextButton()
    }
    func setupInfoContainerView(){
        infoContainerView.top(alertContainerView.topAnchor)
        infoContainerView.left(alertContainerView.leftAnchor)
        infoContainerView.width(alertContainerView.widthAnchor)
        infoContainerViewHeightConstraint = infoContainerView.height(height: 0)
        infoContainerViewHeightConstraint.priority = 100
        infoContainerViewHeightConstraint.isActive = true
    }
    func setupTitleView(){
        titleView.topAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: 8).isActive = true
        titleView.leftAnchor.constraint(equalTo: alertContainerView.leftAnchor).isActive = true
        titleView.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        titleView.addSubview(titleLabel)
        setupTitleLabel()
    }
    func setupTitleLabel(){
        titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: titleView.heightAnchor, multiplier: 0.7).isActive = true
        
    }
    func setupQRImageView(){
        QRImageView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8).isActive = true
        QRImageView.centerXAnchor.constraint(equalTo: alertContainerView.centerXAnchor).isActive = true
        QRImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        QRImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    func setupNameLabel(){
        nameLabel.top(QRImageView.bottomAnchor, constant: 8)
        nameLabel.left(alertContainerView.leftAnchor,constant: 8)
        nameLabel.width(alertContainerView.widthAnchor, constant: -16)
    }
    func setupPhoneLabel(){
        phoneLabel.top(nameLabel.bottomAnchor, constant: 8)
        phoneLabel.left(alertContainerView.leftAnchor,constant: 8)
        phoneLabel.width(alertContainerView.widthAnchor, constant: -16)
    }
    func setupAddressLabel(){
        addressLabel.top(phoneLabel.bottomAnchor, constant: 8)
        addressLabel.left(alertContainerView.leftAnchor,constant: 8)
        addressLabel.width(alertContainerView.widthAnchor, constant: -16)
    }
    func setupSeperatorView(){
        seperatorView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8).isActive = true
        seperatorView.leftAnchor.constraint(equalTo: alertContainerView.leftAnchor).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    func setupNextButton(){
        nextButton.topAnchor.constraint(equalTo: seperatorView.bottomAnchor).isActive = true
        nextButton.leftAnchor.constraint(equalTo: alertContainerView.leftAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: alertContainerView.bottomAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
