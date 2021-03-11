//
//  NewsTableViewController.swift
//  SocialApp
//
//  Created by Иван Казанцев on 08.02.2021.
//

import UIKit
import RealmSwift
import Alamofire


class NewsTableViewController: UITableViewController {
    
    let networkManager = NetworkManager()
    var notificationToken: NotificationToken?
    private lazy var news = try? RealmManager.get(News.self).sorted(byKeyPath: "date", ascending: false)
    var nextFrom: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkManager.loadNews {[weak self] (news, users, groups, timeCode) in
            try? RealmManager.save(items: groups)
            try? RealmManager.save(items: users)
            try? RealmManager.save(items: news)
            self?.nextFrom = timeCode
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else { preconditionFailure("Can't dequeue Cell") }
        
        return cell
    }
    
}
