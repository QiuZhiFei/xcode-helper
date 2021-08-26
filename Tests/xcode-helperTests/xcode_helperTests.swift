import XCTest
import Commands
import class Foundation.Bundle

final class xcode_helperTests: XCTestCase {
  override class func setUp() {
    super.setUp()
    Commands.ENV.global.add(PATH: Bundle.main.bundlePath)
  }
  
  func test_Xcode_Helper_Versions() throws {
    XCTAssertEqual(Commands.Task.run("xcode-helper --version").output,
                   "xcode-helper version 0.0.1")
  }
  
  func test_Xcode_Helper_Help() throws {
    let helpText = """
            OVERVIEW: Xcode helper
            
            USAGE: xcode-helper <subcommand>
            
            OPTIONS:
              --version               Show the version.
              -h, --help              Show help information.
            
            SUBCOMMANDS:
              cache                   Xcode cache helper
            
              See 'xcode-helper help <subcommand>' for detailed help.
            """
    
    XCTAssertEqual(Commands.Task.run("xcode-helper").output, helpText)
    XCTAssertEqual(Commands.Task.run("xcode-helper -h").output, helpText)
    XCTAssertEqual(Commands.Task.run("xcode-helper --help").output, helpText)
  }
}
