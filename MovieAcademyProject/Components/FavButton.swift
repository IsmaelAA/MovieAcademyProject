//
//  FavButton.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 15/2/22.
//

import Foundation
import UIKit

public class FavButton: UIButton {

    var favButPressed = false

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        favButPressed = !favButPressed

        if(favButPressed) {
            setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
