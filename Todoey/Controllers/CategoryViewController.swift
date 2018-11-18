//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Murat Gürbüzdal on 17.11.2018.
//  Copyright © 2018 Murat Gürbüzdal. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var array = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
            let cat = Category(context: self.context)
            cat.name = textField.text!
            
            self.array.append(cat)
            self.saveData()
            
        }
        
        alert.addAction(action)
        
        present(alert,animated: false)
    }
    //MARK: TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = array[indexPath.row].name
        
        return cell
    }
    
    //MARK: Data Manipulation Methods
    //
    func loadData(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            array = try context.fetch(request)
        }catch{
            print("Error fetching data \(error)")
        }
        self.tableView.reloadData()
    }
    
    func saveData(){
        do{
            try context.save()
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
        
        destinationVC.selectedCategory = array[tableView.indexPathForSelectedRow!.row]
    
    }
}
