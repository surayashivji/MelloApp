//
//  DeviceAndIntegrationsViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 24/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class DeviceAndIntegrationsViewController: ModalBaseViewController {
    
    var calendarToggle: CustomSwitch?
    var fitBitToggle: CustomSwitch?

    @IBOutlet var calendarParentView: UIView!
    @IBOutlet weak var fitBitParentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc
    func optionToggled(sender: CustomSwitch) {
        print("Sender..", sender.tag, sender.isOn)
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addAppleWatch(_ sender: Any) {
        print("Adding Apple Watch...")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendarToggle?.isOn = true
    }
    
    func setupView() {
        let calendarToggleRect = CGRect(x: calendarParentView.frame.width - 90, y: 12, width: 81.31, height: 33)
        let fitBitToggleRect = CGRect(x: calendarParentView.frame.width - 90, y: 12, width: 81.31, height: 33)
        
        
        calendarToggle = CustomSwitch(frame: calendarToggleRect)
        calendarToggle?.tag = 1
        fitBitToggle = CustomSwitch(frame: fitBitToggleRect)
        fitBitToggle?.tag = 2
        
        let randomFace = FaceToggle(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        randomFace.setupUI()
        
        calendarToggle?.setupUI()
        fitBitToggle?.setupUI()
        
        calendarToggle?.addTarget(self, action: #selector(optionToggled), for: .valueChanged)
        fitBitToggle?.addTarget(self, action: #selector(optionToggled), for: .valueChanged)
        
        guard let calendarToggle = calendarToggle, let fitBitToggle = fitBitToggle else { return }
        
        self.calendarParentView.addSubview(calendarToggle)
        self.fitBitParentView.addSubview(fitBitToggle)
    }
}
