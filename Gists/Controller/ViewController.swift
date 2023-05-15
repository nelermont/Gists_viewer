//
//  ViewController.swift
//  Gists
//
//  Created by Дмитрий Подольский on 24.06.2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    let baseUrl = URL(string: "https://api.github.com")!
    let path = "/gists"
    var gistsRoot = [GistsRoot]()
    
    @IBOutlet var tableView: UITableView!
    
    let thisRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    var fetchingMore = false
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.addSubview(activityIndicator)
        tableView.refreshControl = thisRefreshControl
        activityIndicator.center = tableView.center
        activityIndicator.startAnimating()
        
        let networkClient = NetworkClient(baseUrl: baseUrl)
        
        Task { @MainActor in
            do {
                let data: [GistsRoot] = try await networkClient.makeRequest(path: path, responseType: [GistsRoot].self)!
                
                activityIndicator.stopAnimating()

                self.gistsRoot = data
                self.tableView.reloadData()
                
            } catch {
                activityIndicator.stopAnimating()
                print(error)
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        
        let networkClient = NetworkClient(baseUrl: baseUrl)
        
        Task { @MainActor in
            do {
                let data: [GistsRoot] = try await networkClient.makeRequest(path: path, responseType: [GistsRoot].self)!
                
                    self.gistsRoot = data
                    self.tableView.reloadData()
                
            } catch {
                print(error)
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


