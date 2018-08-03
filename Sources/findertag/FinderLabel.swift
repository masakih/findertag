//
//  FinderLabel.swift
//  findertag
//
//  Created by Hori,Masaki on 2018/06/08.
//

import Foundation


private var originalFinderLabels = [
    "",
    "Red",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Purple",
    "Gray",
]

private var localizedFinderLabels: [String] = readFinderLabels()

private let labelToNameIndexMap = [
    0: 0,
    1: 7,
    2: 4,
    3: 6,
    4: 5,
    5: 3,
    6: 1,
    7: 2,
]

enum FinderLabel: Int {
    
    case none
    
    case gray
    
    case green
    
    case purple
    
    case blue
    
    case yellow
    
    case read

    case orange
}

//extension FinderLabel {
//
//    init?(name: String) {
//
//        guard let index = primitiveFinderLabels.index(of: name),
//            let label = FinderLabel(rawValue: index) else {
//
//                return nil
//        }
//
//        self = label
//    }
//}

extension FinderLabel {
    
    var name: String {
        
        return labelToNameIndexMap[rawValue].map { originalFinderLabels[$0] } ?? ""
    }
    
    var localizedName: String {
        
        return localizedFinderLabels[self.rawValue]
    }
}


func finderLabels() -> [String] {
    
    return localizedFinderLabels
}

private func readFinderLabels() ->  [String] {
    
    let finderDefaults = UserDefaults(suiteName: "com.apple.Finder")
    return finderDefaults?.object(forKey: "FavoriteTagNames") as? [String] ?? []

}
