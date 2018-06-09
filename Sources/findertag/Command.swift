//
//  Command.swift
//  findertag
//
//  Created by Hori,Masaki on 2018/06/09.
//

import Foundation
import Basic

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
