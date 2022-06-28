//
//  ViewController.swift
//  Gists
//
//  Created by Дмитрий Подольский on 24.06.2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    let parser = Parser()
    var gistsRoot = [GistsRoot]()

    @IBOutlet var tableView: UITableView!
    
    let thisRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    var fetchingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = thisRefreshControl
        
        parser.parse {
            data in
            self.gistsRoot = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        parser.parse {
            data in
            self.gistsRoot = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        sender.endRefreshing()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gistsRoot.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 4
        cell.textLabel?.textColor = .blue
        
        let gistsContent = gistsRoot[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = gistsContent.files.randomId?.filename
        content.secondaryText = gistsContent.owner.login
        content.image = UIImage(data: NSData(contentsOf: NSURL(string: gistsContent.owner.avatar_url! )! as URL)! as Data)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gistData = gistsRoot[indexPath.row]
        let gistFullScreen = GistViewController()
        navigationController?.pushViewController(gistFullScreen, animated: true)
        gistFullScreen.login = gistData.owner.login ?? ""
        gistFullScreen.gistName = gistData.files.randomId?.filename ?? ""
        gistFullScreen.avatar = gistData.owner.avatar_url ??  " "
        gistFullScreen.gistShow = gistData.files.randomId?.raw_url ?? ""
    }
}


