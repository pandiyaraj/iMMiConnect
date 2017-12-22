//
//  ExampleData.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 8/1/17.
//  Copyright © 2017 Yong Su. All rights reserved.
//

import Foundation

//
// MARK: - Section Data Structure
//
public struct Item {
    var name: String
//    var detail: String
    var isSelected : Bool
    public init(name: String,isSelected: Bool) {
        self.name = name
//        self.detail = detail
        self.isSelected = isSelected
    }
}

public struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    public init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

public var sectionsData: [Section] = [
    Section(name: "Chest pain or Discomfort", items: [
        
        Item(name: "Centre or left side of the chest lasting more than a few minutes", isSelected: false),
        Item(name: "Sometimes disappears and comes back", isSelected: false),
        Item(name: "Pressure, squeezing, fullness or pain", isSelected: false),
        Item(name: "Feels like heart burn or indigestion", isSelected: true),
        Item(name: "Radiates to the left shoulder or left arm or jaw or back of the chest or in-between the shoulder blades and sometimes to the right shoulder", isSelected: true),
        Item(name: "Pain in the upper stomach", isSelected: false)
        ], collapsed : false),
    Section(name: "Breathlessness", items: [
        Item(name: "Associated with chest pain", isSelected: false),
        Item(name: "Without chest pain", isSelected: false),
        Item(name: "Occurs at rest", isSelected: false),
        Item(name: "Occurs with some physical activity", isSelected: false)
    ], collapsed : true),
    Section(name: "Others", items: [
        Item(name: "Sweating and excessive tiredness-cold sweat", isSelected: false),
        Item(name: "Nausea and/or vomiting", isSelected: false),
        Item(name: "Light headedness or dizziness", isSelected: false),
        Item(name: "Anxiety or 'fear of impendingdoom", isSelected: false),
        Item(name: "Cough or wheeze", isSelected: false),
        Item(name: "Irregular heart bear causing palpitation and irregular pulse", isSelected: false)
    ], collapsed : true)
]
