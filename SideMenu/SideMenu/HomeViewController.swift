//
//  HomeViewController.swift
//  SideMenu
//
//  Created by Gabriel Chirico Mahtuk de Melo Sanzone on 19/12/23.
//

import Foundation
import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {

    weak var delegate: HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"

        navigationItem.leftBarButtonItem = .init(
            image: UIImage(systemName: "list.dash"),
            style: .done,
            target: self,
            action: #selector(didTapMenuButton)
        )
    }

    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }

}
