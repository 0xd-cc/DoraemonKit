//
//  CPUPlugin.swift
//  Pods
//
//  Created by hash0xd on 2020/6/24.
//

import Foundation

struct CPUPlugin: Plugin {
    static var isOn = false
    
    var module: PluginModule { .performance }
    var title: String { "CPU" }
    var icon: UIImage? { DKImage(named: "doraemon_cpu") }
    
    func onInstall() { /* do nothing */ }
    
    func onSelected() {
        HomeWindow.shared.openPlugin(vc: CPUViewController())
    }
}
