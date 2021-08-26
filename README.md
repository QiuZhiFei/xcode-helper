# xcode-helper

This is a demo that shows how you can create a command-line tools with the Swift Package Manager.

### Quick Start
```
git clone https://github.com/QiuZhiFei/xcode-helper
cd xcode-helper
```
```
> swift run xcode-helper

[0/0] Build complete!
OVERVIEW: Xcode helper

USAGE: xcode-helper <subcommand>

OPTIONS:
  --version               Show the version.
  -h, --help              Show help information.

SUBCOMMANDS:
  cache                   Xcode cache helper

  See 'xcode-helper help <subcommand>' for detailed help.
```

Show Xcode cache files
```
> swift run xcode-helper cache list

[3/3] Build complete!
list cache files:
------------------------
archives
4.9G  /Users/zhifeiqiu/Library/Developer/Xcode/Archives
simulators
5.9G  /Users/zhifeiqiu/Library/Developer/CoreSimulator/Devices
deviceSupport
38G  /Users/zhifeiqiu/Library/Developer/Xcode
derivedData
27G  /Users/zhifeiqiu/Library/Developer/Xcode/DerivedData
previews
135M  /Users/zhifeiqiu/Library/Developer/Xcode/UserData/Previews/Simulator Devices
coreSimulatorCaches
6.2G  /Users/zhifeiqiu/Library/Developer/CoreSimulator/Caches/dyld
```
