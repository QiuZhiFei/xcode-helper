// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "xcode-helper",
  products: [
    .library(
      name: "xcode-helper",
      targets: ["xcode-helper"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
    .package(url: "https://github.com/qiuzhifei/swift-commands", from: "0.3.0"),
  ],
  targets: [
    .target(
      name: "Examples",
      dependencies: [
        "xcode-helper",
        .product(name: "Commands",
                 package: "swift-commands")
      ],
      path: "Examples/"),
    .target(
      name: "xcode-helper",
      dependencies: [
        .product(name: "ArgumentParser",
                 package: "swift-argument-parser"),
        .product(name: "Commands",
                 package: "swift-commands"),
      ]),
    .testTarget(
      name: "xcode-helperTests",
      dependencies: ["xcode-helper"]),
  ]
)
