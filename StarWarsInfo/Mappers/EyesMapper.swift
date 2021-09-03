//
//  EyesMapper.swift
//  StarWarsInfo
//
//  Created by Miguel Cuellar on 02/09/21.
//

import Foundation
import BobaFetch

extension Eyes {
    func mapToPresentation() -> PresentationRecord {
        PresentationRecord(title: name,
                           detail: eyeColor,
                           subtitle: "",
                           type: .People)
    }
}
