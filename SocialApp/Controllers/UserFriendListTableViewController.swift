//
//  UserFriendListTableViewController.swift
//  SocialApp
//
//  Created by Иван Казанцев on 17.01.2021.
//

import UIKit

class UserFriendListTableViewController: UITableViewController {
    
//    var lastNamefirstCharacters = [String]()
//    var groupedFriends = [[String]]()
//    var defaultGroupedFriends = [[String]]()
//    
//    var filteredFriends = [[String]]()
//    private var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else { return false }
//        return text.isEmpty
//    }
//    
//    private var isFiltering: Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
//
//    private let searchController = UISearchController()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Find friend"
//        definesPresentationContext = true
//        navigationItem.searchController = searchController
//        
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        if isFiltering {
//            return filteredFriends.count
//        }
//        return groupedFriends.count
//    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if isFiltering {
//            guard let headerTitle = filteredFriends[section].first?.first else { return nil }
//            return "\(headerTitle)"
//        } else {
//            guard let headerTitle = groupedFriends[section].first?.first else { return nil }
//            return "\(headerTitle)"
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
//            return filteredFriends[section].count
//        }
//        return groupedFriends[section].count
//    }
//    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return lastNamefirstCharacters
//    }
//    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "cellHeaderView")
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "User Friend Cell", for: indexPath) as? UserFriendCell else {
//                preconditionFailure("Can't dequeue Cell")
//            }
//        var friendImage: UIImage = .remove
//        var friendFirstName = String()
//        var completedFriendsArray = [[String]]()
//        
//        if isFiltering {
//            completedFriendsArray = filteredFriends
//        } else {
//            completedFriendsArray = groupedFriends
//        }
//        let friendLastName = completedFriendsArray[indexPath.section][indexPath.row]
//        for index in 0..<friends.count {
//            if friendLastName == friends[index].lastName {
//                friendImage = friends[index].avatar
//                friendFirstName = friends[index].firstName
//            }
//        }
//        
//        cell.friendAvatarImage?.image = friendImage
//        cell.friendNameLabel?.text = ("\(friendLastName)" + " " + "\(friendFirstName)")
//        return cell
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "toFriendProfile" {
//            guard let userProfileCollectionViewController = segue.destination as? UserProfileCollectionViewController else { return }
//            
//            var friendPhotos = [UIImage]()
//            var completedFriendsArray = [[String]]()
//            
//            if let indexPath = tableView.indexPathForSelectedRow {
//                if isFiltering {
//                    completedFriendsArray = filteredFriends
//                } else {
//                    completedFriendsArray = groupedFriends
//                }
//                let friendLastName = completedFriendsArray[indexPath.section][indexPath.row]
//                for index in 0..<friends.count {
//                    if friendLastName == friends[index].lastName {
//                        friendPhotos = friends[index].photos
//                    }
//                }
//                userProfileCollectionViewController.friendPhotos = friendPhotos
//            }
//        }
//    }
//    
//    func arraysActions(incArray: [User]) {
//        for index in 0..<incArray.count {
//            guard let firstCharacter = friends[index].lastName.first else { return }
//            lastNamefirstCharacters.append(String(firstCharacter))
//        }
//        lastNamefirstCharacters = Array(Set(lastNamefirstCharacters)).sorted()
//        
//        for section in 0..<lastNamefirstCharacters.count {
//            var tempString = [String]() //временный массив накопления имен
//             
//            for index in 0..<friends.count {
//                if String(friends[index].lastName.first!) == lastNamefirstCharacters[section] {
//                    tempString.append(String(friends[index].lastName))
//                }
//            }
//            groupedFriends.append(tempString)
//        }
//        defaultGroupedFriends = groupedFriends
//    }

}

//extension UserFriendListTableViewController: UISearchResultsUpdating {

//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//
//    private func filterContentForSearchText(_ searchText: String) {
//            filteredFriends = [[]]
//            for each in groupedFriends {
////                let array = each.filter({ $0.contains(searchController.searchBar.text!)})
//                let array = each.filter({ (friend: String) -> Bool in
//                    return friend.lowercased().contains(searchText.lowercased())
//                })
//                filteredFriends.append(array)
//            }
//        tableView.reloadData()
//    }

//}
