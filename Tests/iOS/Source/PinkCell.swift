//
//  PinkCell.swift
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 12/13/16.
//  Copyright © 2016 Oleksa 'trimm' Korin. All rights reserved.
//

import UIKit

class PinkCell: UITableViewCell {
    func fill(withModel model: Int) {
        self.textLabel?.text = "Awesomeness level = \(model)"
    }
}
