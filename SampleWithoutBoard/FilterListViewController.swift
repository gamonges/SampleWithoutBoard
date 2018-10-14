//
//  FilterListViewController.swift
//  SampleWithoutBoard
//
//  Created by 蒲生廣人 on 2018/09/04.
//  Copyright © 2018年 蒲生廣人. All rights reserved.
//

import UIKit

protocol FilterListViewControllerDelegate: class {
    func filterListViewController(_ controller:FilterListViewController, didSelectFilter
                                filter:String, index:Int)
}

class FilterListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: FilterListViewcontrollerDelegate? = nil
    var selectedIndex: Int = 0

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: indexPath){
        if let myDelegate = delegate{
            myDelegate.filterListViewController(self, didSelectFilter: filterList[indexPath.row], index: indexPath.row)
            let count = (self.navigationController?.viewControllers.count)! - 2
            let previousController = self.navigationController?.viewControllers[count]
            previousController.selectedIndex = selectedIndex

            self.navigationController?.popViewController(animated: true)
        }
    }
    var myTableView : UITableView!

    let titleName: String
    
    init(titleName: String){
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let filterList: [String] = ["",
        "CIPhotoEffectChrome",
        "CiPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIPhotoeffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone",
        "CIVignette"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height

        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight))

        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.delegate = self
        myTableView.dataSource = self

        self.view.addSubview(myTableView)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)

        var filterName = filterList[indexPath.row]
        if filterName.isEmpty {
            filterName = "No Effect"
        }
        cell.textLabel?.text = filterName

        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
