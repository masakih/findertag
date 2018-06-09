//
//  Array-extension.swift
//  findertag
//
//  Created by Hori,Masaki on 2018/06/06.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    
    func unique() -> [Iterator.Element] {
        
        var alreadyAdded = Set<Iterator.Element>()
        
        return filter {
            
            if alreadyAdded.contains($0) {
                
                return false
            }
            
            alreadyAdded.insert($0)
            
            return true
        }
    }
}
