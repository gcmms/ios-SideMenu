//
//  ViewController.swift
//  SideMenu
//
//  Created by Gabriel Chirico Mahtuk de Melo Sanzone on 19/12/23.
//

import UIKit

class ContainerViewController: UIViewController {

    enum MenuState {
        case closed
        case opened
    }

    let menuVC = MenuViewController()
    let homeVC = HomeViewController()

    lazy var navVC = {
        //importante criar a navigationController para facilitar a navegação entre as paginas
        let nav = UINavigationController(rootViewController: homeVC)
        return nav
    }()

    var menuState: MenuState = .closed

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        homeVC.delegate = self
        menuVC.delegate = self

        addChildVC(viewController: menuVC)
        addChildVC(viewController: navVC)
    }

    private func addChildVC(viewController: UIViewController) {
        addChild(viewController)
        /* Adiciona o view controller passado como parâmetro como um filho do view controller atual.
        Isso faz parte do ciclo de vida do UIViewController e é usado para criar uma hierarquia 
        de view controllers. */

        view.addSubview(viewController.view)
        /* Adiciona a view do view controller passado como subview à view do view controller atual.
         Isso significa que a interface do usuário do viewController será exibida dentro da interface do 
         usuário do view controller atual. */

        viewController.didMove(toParent: self)
        /* Notifica o sistema de que a operação de adicionar o view controller como filho foi concluída.
         Isso é importante para garantir que os métodos do ciclo de vida, como viewDidAppear no viewController
         recém-adicionado, sejam chamados corretamente.*/
    }

}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelectItem(item: MenuOption) {
        print("Abrir: \(item.rawValue)")
        didTapMenuButton() //Para fechar o menu
    }

}

extension ContainerViewController: HomeViewControllerDelegate {

    func didTapMenuButton() {
        let initState = menuState
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            options: .curveEaseInOut) {
                self.navVC.view.frame.origin.x = initState == .closed ? self.navVC.view.frame.size.width - 100 : 0 // Se quiser um menu de tela inteira remova o 100
            } completion: { [weak self] done in
                guard let self = self else { return }
                self.menuState = initState == .closed ? .opened : .closed
            }
    }
}

