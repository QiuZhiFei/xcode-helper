import XCTest
import class Foundation.Bundle

extension XCTest {
  public var debugURL: URL {
    let bundleURL = Bundle(for: type(of: self)).bundleURL
    return bundleURL.lastPathComponent.hasSuffix("xctest")
      ? bundleURL.deletingLastPathComponent()
      : bundleURL
  }
  
  public func AssertExecuteCommand(
    command: String,
    expected: String? = nil,
    exitCode: Int32 = EXIT_SUCCESS,
    file: StaticString = #file, line: UInt = #line) {
    let splitCommand = command.split(separator: " ")
    let arguments = splitCommand.dropFirst().map(String.init)
    
    let commandName = String(splitCommand.first!)
    let commandURL = debugURL.appendingPathComponent(commandName)
    guard (try? commandURL.checkResourceIsReachable()) ?? false else {
      XCTFail("No executable at '\(commandURL.standardizedFileURL.path)'.",
              file: (file), line: line)
      return
    }
    
    let process = Process()
    if #available(macOS 10.13, *) {
      process.executableURL = commandURL
    } else {
      process.launchPath = commandURL.path
    }
    process.arguments = arguments
    
    let output = Pipe()
    process.standardOutput = output
    let error = Pipe()
    process.standardError = error
    
    if #available(macOS 10.13, *) {
      guard (try? process.run()) != nil else {
        XCTFail("Couldn't run command process.", file: (file), line: line)
        return
      }
    } else {
      process.launch()
    }
    process.waitUntilExit()
    
    let outputData = output.fileHandleForReading.readDataToEndOfFile()
    let outputActual = String(data: outputData, encoding: .utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let errorData = error.fileHandleForReading.readDataToEndOfFile()
    let errorActual = String(data: errorData, encoding: .utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if let expected = expected {
      XCTAssertEqual(expected, errorActual + outputActual)
    }
    
    XCTAssertEqual(process.terminationStatus, exitCode, file: (file), line: line)
  }
}

final class xcode_helperTests: XCTestCase {
  func test_Xcode_Helper_Versions() throws {
    AssertExecuteCommand(command: "xcode-helper --version",
                         expected: "xcode-helper version 0.0.1")
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
    
    AssertExecuteCommand(command: "xcode-helper", expected: helpText)
    AssertExecuteCommand(command: "xcode-helper -h", expected: helpText)
    AssertExecuteCommand(command: "xcode-helper --help", expected: helpText)
  }
}
