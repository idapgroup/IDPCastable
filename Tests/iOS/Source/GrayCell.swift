//
//  GrayCell.swift
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 12/13/16.
//  Copyright © 2016 Oleksa 'trimm' Korin. All rights reserved.
//

import UIKit

class GrayCell: UITableViewCell {
    func fill(withModel model: String) {
        self.textLabel?.text = model
    }
}
