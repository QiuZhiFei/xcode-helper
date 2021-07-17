// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "xcode-helper",
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
  ],
  targets: [
    .target(
      name: "xcode-helper",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]),
    .testTarget(
      name: "xcode-helperTests",
      dependencies: ["xcode-helper"]),
  ]
)
