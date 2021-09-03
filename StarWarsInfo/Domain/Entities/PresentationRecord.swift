//
//  PresentationRecord.swift
//  StarWarsInfo
//
//  Created by Miguel Cuellar on 02/09/21.
//

import Foundation

enum Category: Int, CaseIterable {
    case People
    case Planets
    case Films
}

struct PresentationRecord {
    let title: String
    let detail: String
    let subtitle: String
    let type: Category
}
