//
//  CPUViewController.swift
//  DoraemonKit-Swift
//
//  Created by hash0xd on 2020/6/24.
//

import UIKit

class CPUViewController: BaseViewController {
    static let oscillogramView = OscillogramView()
    let switchView = CellSwitch(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        set(title: LocalizedString("CPU检测"))
        
        
        switchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(switchView)
        if #available(iOS 11.0, *) {
            switchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            switchView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        let switchViewConstraints = [
            switchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            switchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            switchView.heightAnchor.constraint(equalToConstant: CellSwitch.defaultHeight)
        ]
        NSLayoutConstraint.activate(switchViewConstraints)
        
        switchView.renderUIWithTitle(title: LocalizedString("CPU检测开关"), on: CPUPlugin.isOn)
        switchView.needTopLine()
        switchView.needDownLine()
        switchView.delegate = self
    }

}


extension CPUViewController: CellSwitchDelegate {
    func changeSwitchOn(on: Bool) {
        CPUPlugin.isOn = on
        if on {
            OscillogramWindowManager.shared.add(oscillogramView: CPUViewController.oscillogramView)
            CPUViewController.oscillogramView.delegate = self
        } else {
            oscillogramViewDidColsed()
        }
    }
}

extension CPUViewController: OscillogramViewDelegate {
    var oscillogramMaxValue: Double {
        return 100
    }
    
    func collectData() -> Double {
        Performance.cpuUsage
    }
    
    func oscillogramViewDidColsed() {
        CPUPlugin.isOn = false
        OscillogramWindowManager.shared.remove(oscillogramView: CPUViewController.oscillogramView)
        switchView.renderUIWithTitle(title: LocalizedString("CPU检测开关"), on:  CPUPlugin.isOn)
    }
}
