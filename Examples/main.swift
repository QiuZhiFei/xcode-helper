//
//  main.swift
//  
//
//  Created by zhifei qiu on 2021/8/26.
//

import Foundation
import Commands

//Bundle(for: type(of: self)).bundleURL

//debugPrint(Bundle.main.bundleURL)

//Commands.Task.system("xcode-helper --version")

//Commands.Task.system("ls")

var request: Commands.Request = "\(Bundle.main.bundlePath)/xcode-helper --version"
Commands.Task.system(request)
debugPrint("ls")
