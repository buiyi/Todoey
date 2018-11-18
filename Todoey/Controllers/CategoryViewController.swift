//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Murat Gürbüzdal on 17.11.2018.
//  Copyright © 2018 Murat Gürbüzdal. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var array : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadData()
    }

    //MARK: Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let cat = Category()
            cat.name = textField.text!
        
            self.save(category: cat)
            
        }
        
        alert.addAction(action)
        
        present(alert,animated: false)
    }
    //MARK: TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = array?[indexPath.row].name ?? "No Categories Added"
        
        return cell
    }
    
    //MARK: Data Manipulation Methods
    //
    func loadData(){
        array = realm.objects(Category.self)
        self.tableView.reloadData()
    }
    
    func save(category : Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error fetching data \(error)")
        }
        self.tableView.reloadData()
    }
    //MARK: TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        destinationVC.selectedCategory = array?[tableView.indexPathForSelectedRow!.row]
    
    }
}
