//
//  FriendsListViewController.swift
//  SocialApp
//
//  Created by Иван Казанцев on 28.03.2021.
//

import UIKit
import RealmSwift
import PromiseKit
import Kingfisher

class FriendsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var lettersStackView: UIStackView!
    
    let networkManager = NetworkManager()
    private lazy var usernames = try? RealmManager.get(User.self).filter("is_friend == %@", 1)
    private var notificationToken: NotificationToken?
    var firstLetters = [Character]()
    var sortedUsers: [Character: [User]] = [:]
    private let realmQ = DispatchQueue(label: "realmQ", qos: .default, attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        networkManager.friendsGet()
            .get(on: realmQ) { users in
                try? RealmManager.save(items: users)
            }
            .done(on: .main) { users in

            }
            .catch(on: .main) { error in
                self.show(error)
            }
            .finally {
                self.tableView.reloadData()
            }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationToken = usernames?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                self.tableView.reloadData()
            case let .update (_, deletions, insertions, modifications):
                (self.firstLetters, self.sortedUsers) = (self.sortUsers(self.usernames!))
                self.createStackView(self.firstLetters)
                self.tableView.reloadData()

            case .error(let error):
                self.show(error)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationToken?.invalidate()
    }
    
    func createStackView(_ letters: [Character]) {
        for letter in letters{
            let label = UIButton()
            label.setTitle(String(letter), for: .normal)
            label.contentHorizontalAlignment = .center
            label.contentVerticalAlignment = .center
            label.addTarget(self, action: #selector(scrollToSection), for: .touchUpInside)
            lettersStackView.addArrangedSubview(label)
        }
    }
    
    @objc private func scrollToSection(_ sender: UIButton){
        for (index, letter) in firstLetters.enumerated(){
            if let presedLetter = sender.title(for: .selected){
                if String(letter) == presedLetter {
                    tableView.scrollToRow(at: [index, 0], at: .top, animated: true)
                }
            }
        }
    }
    
}

extension FriendsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.tableView.cellForRow(at: indexPath)?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: {_ in
            UIView.animate(withDuration: 0.05, animations: {
                self.tableView.cellForRow(at: indexPath)?.transform = CGAffineTransform.identity
            }, completion: {_ in
                //self.performSegue(withIdentifier: "showImages", sender: self)
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
        })
    }
    
}

extension FriendsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return firstLetters.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letter = firstLetters[section]
        let usersCount = sortedUsers[letter]?.count
        return usersCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell else { preconditionFailure("Error with Cell: MainTableCell") }
        let letter = firstLetters[indexPath.section]
        if let user = sortedUsers[letter]{
            cell.configureUser(with: user[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FriendCell else {return}
        UIView.transition(with: cell, duration: 1, options: .transitionFlipFromBottom, animations: {
            //            cell.avatar.transform = CGAffineTransform (scaleX: 0.6, y: 0.6)
        }, completion: {_ in
            //            cell.avatar.transform = CGAffineTransform (scaleX: 1, y: 1)
        })
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(firstLetters[section])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 95
        return height
    }
    
    func sortUsers (_ users: Results<User>) -> (character: [Character], sortedUsers: [Character: [User]]){
        var characters = [Character]()
        var sortedUsers = [Character: [User]]()
        self.usernames?.forEach { user in
            guard let firstLetter = user.lastName.first else {return}
            if var letterInUsers = sortedUsers[firstLetter]{
                letterInUsers.append(user)
                sortedUsers[firstLetter] = letterInUsers
            } else {
                sortedUsers[firstLetter] = [user]
                characters.append(firstLetter)
            }
        }
        characters.sort()
        return (characters, sortedUsers)
    }

    
    
}

