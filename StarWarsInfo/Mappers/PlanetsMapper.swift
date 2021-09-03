//
//  PlanetsMapper.swift
//  StarWarsInfo
//
//  Created by Miguel Cuellar on 03/09/21.
//

import Foundation
import BobaFetch

extension Planet {
    func mapToPresentation() -> PresentationRecord {
        PresentationRecord(title: name,
                           detail: climate,
                           subtitle: population,
                           type: .Planets)
    }
}

