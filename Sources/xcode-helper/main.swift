import Foundation
import ArgumentParser
import Commands

struct Constant {
  struct App {
    static let version = "0.0.1"
  }
}

struct Print {
  enum Color: String {
    case reset = "\u{001B}[0;0m"
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
  }
  
  static func h3(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    // https://stackoverflow.com/questions/39026752/swift-extending-functionality-of-print-function
    let output = items.map { "\($0)" }.joined(separator: separator)
    print("\(Color.green.rawValue)\(output)\(Color.reset.rawValue)")
  }
  
  static func h6(_ verbose: Bool, _ items: Any..., separator: String = " ", terminator: String = "\n") {
    if verbose {
      let output = items.map { "\($0)" }.joined(separator: separator)
      print("\(output)")
    }
  }
}

extension XcodeHelper {
  enum CacheFolder: String, ExpressibleByArgument, CaseIterable {
    case all
    case archives
    case simulators
    case deviceSupport
    case derivedData
    case previews
    case coreSimulatorCaches
  }
}

fileprivate extension XcodeHelper.CacheFolder {
  var paths: [String] {
    switch self {
    case .archives:
      return ["~/Library/Developer/Xcode/Archives"]
    case .simulators:
      return ["~/Library/Developer/CoreSimulator/Devices"]
    case .deviceSupport:
      return ["~/Library/Developer/Xcode"]
    case .derivedData:
      return ["~/Library/Developer/Xcode/DerivedData"]
    case .previews:
      return ["~/Library/Developer/Xcode/UserData/Previews/Simulator Devices"]
    case .coreSimulatorCaches:
      return ["~/Library/Developer/CoreSimulator/Caches/dyld"]
    case .all:
      var paths: [String] = []
      for caseValue in Self.allCases {
        if caseValue != self {
          paths.append(contentsOf: caseValue.paths)
        }
      }
      return paths
    }
  }
  
  static var suggestion: String {
    let suggestion = Self.allCases.map { caseValue in
      return caseValue.rawValue
    }.joined(separator: " | ")
    return "[ \(suggestion) ]"
  }
}

struct XcodeHelper: ParsableCommand {
  public static let configuration = CommandConfiguration(
    abstract: "Xcode helper",
    version: "xcode-helper version \(Constant.App.version)",
    subcommands: [
      Cache.self
    ]
  )
}

extension XcodeHelper {
  struct Cache: ParsableCommand {
    public static let configuration = CommandConfiguration(
      abstract: "Xcode cache helper",
      subcommands: [
        List.self
      ]
    )
  }
}

extension XcodeHelper.Cache {
  struct List: ParsableCommand {
    public static let configuration = CommandConfiguration(
      abstract: "Show Xcode cache files"
    )
    
    @Option(name: .shortAndLong, help: "The cache folder")
    private var cacheFolder: XcodeHelper.CacheFolder = .all
    
    @Flag(name: .shortAndLong, help: "Show extra logging for debugging purposes.")
    private var verbose: Bool = false
    
    func run() throws {
      Print.h3("list cache files:")
      Print.h3("------------------------")
      
      if cacheFolder == .all {
        var allCases = XcodeHelper.CacheFolder.allCases
        allCases.remove(at: allCases.firstIndex(of: .all)!)
        handleList(allCases)
      } else {
        handleList([cacheFolder])
      }
    }
    
    private func handleList(_ folders: [XcodeHelper.CacheFolder]) {
      for folder in folders {
        Print.h3(folder.rawValue)
        for path in folder.paths {
          let cmd = "du -hs \(path)"
          Print.h6(verbose, cmd)
          Commands.Task.system("\(cmd)")
        }
      }
    }
  }
}

XcodeHelper.main()
