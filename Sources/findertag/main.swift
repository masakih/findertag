
import Foundation
import Basic
import Utility

do {
    
    let (parser, binder) = build()
    
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
} catch {
    
    print("Error:", error)
}
