//
//  FilmsMapper.swift
//  StarWarsInfo
//
//  Created by Miguel Cuellar on 03/09/21.
//

import Foundation
import BobaFetch

extension Film {
    func mapToPresentation() -> PresentationRecord {
        PresentationRecord(title: title,
                           detail: openingCrawl,
                           subtitle: releaseDate,
                           type: .Films)
    }
}
