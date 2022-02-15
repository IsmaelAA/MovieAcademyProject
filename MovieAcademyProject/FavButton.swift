//
//  FavButton.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 15/2/22.
//

import Foundation
import UIKit

public class FavButton: UIButton {
    private let offset = CGFloat(2.0) // 2 point

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.imageView?.contentMode = .scaleAspectFit
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        let edge = bounds.height / 3 - offset
        self.imageEdgeInsets = UIEdgeInsets(top: edge, left: 0, bottom: edge, right: 0)
    }
}
