//  QuoteTableViewCell.swift
//  YOUTIR
//
//  Created by Tom Malary on 4/12/15.
//  Copyright (c) 2015 YOUTIR LLC. All rights reserved.

import UIKit

class QuoteTableViewCell: UITableViewCell {

    @IBOutlet var carrierName: UILabel!
    @IBOutlet var transitRate: UILabel!
    @IBOutlet var transitTime: UILabel!
    @IBOutlet var logoImage: PFImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setQuote(quote: Quote){
//        
//    }
    
    func setQuoteCell(carrierName: String, transitRate: Int, transitTime: Int, logoImageView: PFImageView){
        self.carrierName.text = carrierName
        self.transitRate.text = String(transitRate)
        self.transitTime.text = String(transitTime)
        self.logoImage = logoImageView
    }
}
