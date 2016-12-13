//
//  ViewController.swift
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 12/12/16.
//  Copyright © 2016 Oleksa 'trimm' Korin. All rights reserved.
//

import UIKit
import IDPCastable

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = (indexPath.row % 2) == 0 ? "GrayCell" : "PinkCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        return castable(cell) { (c: PinkCell) in
                c.fill(withModel: indexPath.row)
            }
            .match { (c: GrayCell) in
                c.fill(withModel: "row = \(indexPath.row), column = \(indexPath.section)")
            }
            .extract()
    }
}

