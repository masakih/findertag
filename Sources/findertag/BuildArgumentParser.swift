//
//  BuildArgumentParser.swift
//  findertag
//
//  Created by Hori,Masaki on 2018/06/09.
//

import Foundation
import Basic
import Utility

func build() -> (ArgumentParser, ArgumentBinder<Command>) {
    
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
    
    return (parser, binder)
}
