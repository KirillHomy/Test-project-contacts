//
//  TPCTableViewController.swift
//  Test project contacts
//
//  Created by Кирилл on 23.06.2022.
//

import UIKit
import Contacts

class TPCTableViewController: UITableViewController {

    
    var itemImage = ["person","person.2.fill","list.number","person.fill.xmark","iphone.homebutton.slash","mail.fill"]
    var itemArray = ["Все контакты","Дублирующиеся имена ","Дублирующиеся номера","Нет имени ","Нет номера","Нет емейла"]
    var allArraies = [Any]()
    
    var store = CNContactStore()
    
    var count = Int()
    var repeatNameAll = [CNContact]()
    var repeatNmberAll = [CNContact]()
    var emptyName = [CNContact]()
    var numberAll = [CNContact]()
    var mailAll = [CNContact]()
    
    var allContactsNames = [String]()
    var allContactsPhones = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let autorized = CNContactStore.authorizationStatus(for: .contacts)
        if autorized == .notDetermined {
            store.requestAccess(for: .contacts) {( success, error) in
                if error == nil {
                }
            }
        }else if autorized == .authorized {
            getContactList()
        }
        allArraies = [count,repeatNameAll.count,repeatNmberAll.count,emptyName.count,numberAll.count,mailAll.count]
    }
    
    func getContactList () {
        
        var myContacts = [MyContats]()
        
        let keys = [CNContactGivenNameKey,CNContactEmailAddressesKey,CNContactPhoneNumbersKey]
        let requst = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do {
            try! store.enumerateContacts(with: requst) { (contact, stopPointar) in
                
                self.count += 1
                
                if self.allContactsNames.contains(contact.givenName) {
                    self.repeatNameAll.append(contact)
                } else {
                    self.allContactsNames.append(contact.givenName)
                }
                
                if self.allContactsPhones.contains(contact.phoneNumbers.first?.value.stringValue ?? "") {
                    self.repeatNmberAll.append(contact)
                } else {
                    self.allContactsPhones.append(contact.phoneNumbers.first?.value.stringValue ?? "")
                    }
    
                if contact.givenName.isEmpty {
                    self.emptyName.append(contact)
                }
                
                if contact.emailAddresses.isEmpty {
                    self.mailAll.append(contact)
                }
                if contact.phoneNumbers.isEmpty {
                    self.numberAll.append(contact)
                }
             
                myContacts.append(MyContats(name: contact.givenName, phone: contact.phoneNumbers.first?.value.stringValue ?? "", email: (contact.emailAddresses.first?.value ?? "") as String))
                
                
                
             
            }
        }catch{
            print("Error")
        }
    }
    

    // MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TPCTableViewCell
        
        cell.nameLabelCell.text = itemArray[indexPath.row]
        cell.countLabelCell.text = "\(allArraies[indexPath.row])"
        cell.imageCell.image = UIImage(systemName: itemImage[indexPath.row])
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
