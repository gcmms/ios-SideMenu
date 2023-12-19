//
//  MenuViewController.swift
//  SideMenu
//
//  Created by Gabriel Chirico Mahtuk de Melo Sanzone on 19/12/23.
//

import Foundation
import UIKit

enum MenuOption: String, CaseIterable {
    case home
    case about
    case settings

    var icon: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .about:
            return UIImage(systemName: "star")
        case .settings:
            return UIImage(systemName: "gear")
        }
    }
}

protocol MenuViewControllerDelegate: AnyObject {
    func didSelectItem(item: MenuOption)
}

final class MenuViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
        table.backgroundColor = nil
        return table
    }()

    weak var delegate: MenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.bounds.size.width,
            height: view.bounds.size.height
        )
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOption.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        let menuItem = MenuOption.allCases[indexPath.row]
        cell.textLabel?.text = menuItem.rawValue.capitalized
        cell.textLabel?.textColor = .white
        cell.imageView?.image = menuItem.icon
        cell.imageView?.tintColor = .white
        cell.backgroundColor = .purple
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let menuItem = MenuOption.allCases[indexPath.row]
        delegate?.didSelectItem(item: menuItem)
    }

}
