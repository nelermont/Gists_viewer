//
//  GistViewController.swift
//  Gists
//
//  Created by Дмитрий Подольский on 06.05.2023.
//

import Foundation
import UIKit

class GistViewController: UIViewController {

    var login = ""
    var gistName = ""
    var avatar = ""
    var gistShow = ""
  
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
  
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    private let gistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    private let htmlGistTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundView = UIView()
         backgroundView.backgroundColor = .white
         view.addSubview(backgroundView)
         backgroundView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
             backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
       
        configureSubviews()

        fetchData()
    }
  
    private func configureSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(loginLabel)
        view.addSubview(gistNameLabel)
        view.addSubview(htmlGistTextView)
        
        loginLabel.text = login
        gistNameLabel.text = gistName
        avatarImageView.image = UIImage(data: NSData(contentsOf: NSURL(string: avatar )! as URL)! as Data)
        
        htmlGistTextView.text = gistShow
        
        let userStackView = UIStackView(arrangedSubviews: [avatarImageView, loginLabel])
           userStackView.translatesAutoresizingMaskIntoConstraints = false
           userStackView.axis = .horizontal
           userStackView.distribution = .fill
           userStackView.spacing = 16
           
           let gistStackView = UIStackView(arrangedSubviews: [gistNameLabel, htmlGistTextView])
           gistStackView.translatesAutoresizingMaskIntoConstraints = false
           gistStackView.axis = .vertical
           gistStackView.distribution = .fill
           gistStackView.spacing = 8
           
           view.addSubview(userStackView)
           view.addSubview(gistStackView)
           
           avatarImageView.image = UIImage(data: NSData(contentsOf: NSURL(string: avatar )! as URL)! as Data)
           loginLabel.text = login
           gistNameLabel.text = gistName
      
   
        avatarImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        avatarImageView.layer.cornerRadius = 15
        avatarImageView.clipsToBounds = true
        
           NSLayoutConstraint.activate([
               userStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
               userStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               userStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

               gistStackView.topAnchor.constraint(equalTo: userStackView.bottomAnchor, constant: 8),
               gistStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               gistStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               gistStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
           ])
    }
    
    private func fetchData() {
        guard let myURL = URL(string: gistShow) else {
            print("Error: \(gistShow) doesn't seem to be a valid URL")
            return
        }
    
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            htmlGistTextView.text = myHTMLString
        } catch let error {
            print("Error: \(error)")
        }
    }
}
