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
    0: 0,   // none
    1: 7,   // Gray
    2: 4,   // Green
    3: 6,   // Purple
    4: 5,   // Blue
    5: 3,   // Yellow
    6: 1,   // Red
    7: 2,   // Orange
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

extension FinderLabel {
    
    var name: String {
        
        return labelToNameIndexMap[rawValue].map { originalFinderLabels[$0] } ?? ""
    }
    
    var localizedName: String {
        
        return labelToNameIndexMap[rawValue].map { localizedFinderLabels[$0] } ?? ""
    }
}


func finderLabels() -> [String] {
    
    return localizedFinderLabels
}

private func readFinderLabels() ->  [String] {
    
    let finderDefaults = UserDefaults(suiteName: "com.apple.Finder")
    return finderDefaults?.object(forKey: "FavoriteTagNames") as? [String] ?? []

}
