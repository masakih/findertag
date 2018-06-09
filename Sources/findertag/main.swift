
import Foundation
import Basic
import Utility

struct Command {
    
    enum CommandType: String {
        
        case view
        
        case append
        
        case remove
        
        case delete
        
        case label
        
        case viewLabel
    }
    
    var type: CommandType = .view
    
    var tag: String?
    
    var labelNumber: Int = 0
    
    var files: [AbsolutePath] = []
    
    var recursive: Bool = false
}


let parser = ArgumentParser(usage: "SUBCOMMAND file(s)", overview: "Finder tag accessor")
let binder = ArgumentBinder<Command>()

let viewCommand = parser.add(subparser: Command.CommandType.view.rawValue, overview: "View tags.")
binder.bind(
    option: viewCommand.add(option: "--recursive",
                            shortName: "-r",
                            kind: Bool.self,
                            usage: "Recursive"),
    to: { $0.recursive = $1 })
binder.bind(
    positional: viewCommand.add(positional: "Path", kind: [PathArgument].self),
    to : { $0.files = $1.map { $0.path } })

let appendCommand = parser.add(subparser: Command.CommandType.append.rawValue, overview: "Append tag.")
binder.bind(
    positional: appendCommand.add(
        positional: "Tag",
        kind: String.self,
        usage: "Tag name"),
    to: { $0.tag = $1 })
binder.bind(
    positional: appendCommand.add(positional: "Path", kind: [PathArgument].self),
    to: { $0.files = $1.map { $0.path } })

let removeCommand = parser.add(subparser: Command.CommandType.remove.rawValue, overview: "Remove tag.")
binder.bind(
    positional: removeCommand.add(
        positional: "Tag",
        kind: String.self,
        usage: "Tag name"),
    to: { $0.tag = $1 })
binder.bind(
    positional: removeCommand.add(positional: "Path", kind: [PathArgument].self),
    to: { $0.files = $1.map { $0.path } })

let deleteCommand = parser.add(subparser: Command.CommandType.delete.rawValue, overview: "Delete all tags.")
binder.bind(
    positional: deleteCommand.add(positional: "Path", kind: [PathArgument].self),
    to: { $0.files = $1.map { $0.path } })

let labelCommand = parser.add(subparser: Command.CommandType.label.rawValue, overview: "Set label with number.")
binder.bind(
    positional: labelCommand.add(
        positional: "Label",
        kind: Int.self,
        usage: "Label number"),
    to: { $0.labelNumber = $1 })
binder.bind(
    positional: labelCommand.add(positional: "Path", kind: [PathArgument].self),
    to: { $0.files = $1.map { $0.path } })


let viewLabelCommand = parser.add(subparser: Command.CommandType.viewLabel.rawValue, overview: "View Label Number.")
binder.bind(
    option: viewLabelCommand.add(option: "--recursive",
                            shortName: "-r",
                            kind: Bool.self,
                            usage: "Recursive"),
    to: { $0.recursive = $1 })
binder.bind(
    positional: viewLabelCommand.add(positional: "Path", kind: [PathArgument].self),
    to : { $0.files = $1.map { $0.path } })

binder.bind(parser: parser, to: { $0.type = Command.CommandType(rawValue: $1)! })

do {
    
    let result = try parser.parse(Array(CommandLine.arguments.dropFirst()))
    
    var command = Command()
    
    binder.fill(result, into: &command)
    
    let finderTags = command
        .files
        .map { Foundation.URL(fileURLWithPath: $0.asString) }
        .compactMap { FinderTag(fileURL: $0) }
    
    switch command.type {
        
    case .view:
        
        prityPrint(finderTags.compactMap { $0.view(recurcive: command.recursive) })
        
    case .append:
        
        finderTags.forEach { $0.append(tag: command.tag!) }
        
    case .remove:
        
        finderTags.forEach { $0.remove(tag: command.tag!)}
        
    case .delete:
        
        finderTags.forEach { $0.delete() }
        
    case .label:
        
        guard case (0...7) = command.labelNumber else {
            
            print("Label number must be between 0 to 7.")
            exit(-1)
        }
        finderTags.forEach { $0.labelNumber = command.labelNumber }
        
    case .viewLabel:
        
        finderTags.forEach { $0.labelNumber.map { print($0) } }
    }
}
catch {
    
    print("Error:", error)
}
