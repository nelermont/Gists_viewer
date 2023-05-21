//
//  GistCell.swift
//  Gists
//
//  Created by Дмитрий Подольский on 06.05.2023.
//

import Foundation
import UIKit

class GistCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with gist: GistsRoot) {
        textLabel?.numberOfLines = 0
        textLabel?.textColor = .black
        
        var content = defaultContentConfiguration()
        
        content.textProperties.numberOfLines = 0
        content.text = gist.files.randomId?.filename
        content.secondaryText = gist.owner.login
        content.image = UIImage(data: NSData(contentsOf: NSURL(string: gist.owner.avatar_url! )! as URL)! as Data)
        
        let imageSize = CGSize(width: 50, height: 50)
        content.imageProperties.maximumSize = imageSize
        content.imageProperties.cornerRadius = 15
        content.imageProperties.reservedLayoutSize = imageSize
        content.imageProperties.preferredSymbolConfiguration = UIImage.SymbolConfiguration(scale: .medium)
        
        contentConfiguration = content
    }
}
