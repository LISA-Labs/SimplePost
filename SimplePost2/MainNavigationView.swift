//
//  MainNavigationView.swift
//  memo
//
//  Created by 이덕화 on 2016. 12. 11..
//  Copyright © 2016년 memo. All rights reserved.
//

import UIKit

class MainNavigationView: UIView {
    
    // MARK: - Vars
    
    var containerView:UIView!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dividerImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitialization()
    }
    
    func commonInitialization() {
        containerView = Bundle.main.loadNibNamed("MainNavigationView", owner: self, options: nil)?.first as! UIView
        containerView.frame = self.bounds
        self.addSubview(containerView)
    }
    
    func initVars() {
        
    }
    
    func initBackgroundView() {
        self.containerView.backgroundColor = blueColor
    }
    
    func initButtons() {
        self.leftButton.isHidden = true
        self.rightButton.isHidden = true
    }
    
    func initTitleLabel() {
        self.titleLabel.font = UIFont.init(name: "AppleSDGothicNeo-Bold", size: 17.0)
        self.titleLabel.textColor = .white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
        self.initButtons()
        self.initTitleLabel()
    }
    
    // MARK: -
    
    func setBGColor(color: UIColor) {
        self.containerView.backgroundColor = color
    }
    
    func setTitle(title: String?) {
        self.titleLabel.text = title
    }
    
    func setTitleColor(color: UIColor) {
        self.titleLabel.textColor = color
    }
}
