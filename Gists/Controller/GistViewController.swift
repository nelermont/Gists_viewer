//
//  GistViewController.swift
//  Gists
//
//  Created by Дмитрий Подольский on 27.06.2022.
//

import UIKit

class GistViewController: UIViewController {
    
    var cont = [GistsRoot]()
    
    var login = ""
    var gistName = ""
    var avatar = ""
    var gistShow = ""
    
    @IBOutlet weak var avatarUI: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var gName: UILabel!
    @IBOutlet weak var htmlGist: UITextView!
    @IBOutlet weak var gistView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginLabel.text = login
        gName.text = gistName
        avatarUI.image = UIImage(data: NSData(contentsOf: NSURL(string: avatar )! as URL)! as Data)
        htmlGist.text = gistShow
        
        //получение значений HTML
        guard let myURL = URL(string: gistShow) else {
            print("Error: \(gistShow) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            htmlGist.text = myHTMLString
        } catch let error {
            print("Error: \(error)")
        }
    }
    
}



