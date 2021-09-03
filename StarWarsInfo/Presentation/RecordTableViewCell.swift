//
//  RecordTableViewCell.swift
//  StarWarsInfo
//
//  Created by Miguel Cuellar on 03/09/21.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var recordImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(record: PresentationRecord) {
        titleLbl.text = record.title
        subtitleLbl.text = record.detail
        
        switch record.type {
        case .People:
            recordImageView.image = UIImage(systemName: "person.crop.square")
            detailLbl.text = record.subtitle
        case .Films:
            recordImageView.image = UIImage(systemName: "film")
            detailLbl.text = record.subtitle
        case .Planets:
            recordImageView.image = UIImage(systemName: "map")
            detailLbl.text = "Population: \(record.subtitle)"

        }
    }
    
}
