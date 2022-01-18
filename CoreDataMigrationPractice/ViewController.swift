//
//  ViewController.swift
//  CoreDataMigrationPractice
//
//  Created by 정성훈 on 2022/01/13.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    private var container: NSPersistentContainer {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    private var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    private var dataSource: UITableViewDiffableDataSource<Int, NSManagedObjectID>!
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private lazy var fetchedResultController: NSFetchedResultsController<User> = {
        let fetchRequest = User.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        dataSource = UITableViewDiffableDataSource<Int, NSManagedObjectID>(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, itemIdentifier in
            guard let object = self?.fetchedResultController.object(at: indexPath) else {
                fatalError()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
            
            var configuration = cell.defaultContentConfiguration()
            
            configuration.text = object.wrappedName
            configuration.secondaryText = object.wrappedGenderName
            
            cell.contentConfiguration = configuration
            return cell
        })
        
        try? fetchedResultController.performFetch()
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        dataSource.apply(snapshot as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>)
    }
}


