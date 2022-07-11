//
//  ViewController.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 01.07.2022.
//

import UIKit

class MainViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    var mainView: MainView!
    private var viewModel: MainViewModelProtocol
    private lazy var collectionView = mainView.collectionView
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        updateView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        viewModel.startFetch(parse: ViewData.DataToFetch.personal)
        viewModel.startFetch(parse: ViewData.DataToFetch.equipment)
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func createView() {
        mainView = MainView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
    }
    
    private func updateView() {
        viewModel.updateViewData = { [weak self] viewData in
            self?.mainView.viewData = viewData
            self?.collectionView.reloadData()
            if String(describing: viewData).contains("failure") {
                self?.showAlert(errorMessage: viewData)
            }
        }
    }
    
    private func showAlert(errorMessage: ViewData?) {
        if let errorMessage = errorMessage {
            let alertController = UIAlertController(title: "Error", message: String(describing: errorMessage), preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
}
