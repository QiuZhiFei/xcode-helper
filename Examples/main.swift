//
//  main.swift
//  
//
//  Created by zhifei qiu on 2021/8/26.
//

import Foundation
import Commands

Commands.ENV.global.add(PATH: Bundle.main.bundlePath)

Commands.Task.system("xcode-helper")

Commands.Task.system("xcode-helper --version")

Commands.Task.system(
  Commands.Request(executableURL: "xcode-helper",
                   arguments: ["cache", "list"])
)

