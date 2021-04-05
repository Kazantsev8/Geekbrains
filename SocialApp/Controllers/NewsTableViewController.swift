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
    private let realmQ = DispatchQueue(label: "realmQ", qos: .default, attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        networkManager.newsFeedGet()
            .get(on: realmQ) { (news, groups, users, timeCode) in
                try? RealmManager.save(items: news)
                try? RealmManager.save(items: groups)
                try? RealmManager.save(items: users)
                self.nextFrom = timeCode
            }
            .done(on: .main) { users in

            }
            .catch(on: .main) { error in
                self.show(error)
            }
            .finally {
                self.tableView.reloadData()
            }
        print(news)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else { preconditionFailure("Error with Cell: MainTableCell") }
        return cell
    }

    
}
