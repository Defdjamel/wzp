//
//  ViewController.swift
//  wzp_challenge
//
//  Created by james on 14/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import SVProgressHUD
private let reuseIdentifier = "IconTableViewCell"
class ListViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var icons : [Icon] = []
    var searchBarView : SearchBarView!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI()
        getDataFromCache()
        pullDataFromNetwork()
        observerKeyboard()
    }
    func initUI(){
        self.tableView.register(UINib.init(nibName: reuseIdentifier, bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)
        self.tableView.tableHeaderView = self.getTitleView()
        searchBarView = SearchBarView.instanceFromNib() as? SearchBarView
        searchBarView.searchBar.delegate = self
        
    }
    func pullDataFromNetwork(){
        SVProgressHUD.show()
        NetworkManager.sharedInstance.getListIcons(success: { (data) in
            self.icons = data
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }) {//failed
            SVProgressHUD.showError(withStatus: nil)
        }
    }
    func getDataFromCache(){
        self.icons = IconsManager.sharedInstance.getAllIcon()
        self.tableView.reloadData()
    }
    func searchDataWithText(_ text: String){
        self.icons = IconsManager.sharedInstance.getIconBySearchText(text)
        self.tableView.reloadData()
    }
    
     //MARK: - TitleView
    func getTitleView() -> UIView {
        let lbl = UILabel.init(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width, height: 60))
        lbl.text = "Custom Icons"
        lbl.font = UIFont.systemFont(ofSize: 41, weight: .bold)
        let headerView:UIView = UIView(frame: CGRect(x: 0, y:0, width:lbl.frame.size.width, height: lbl.frame.size.height))
        headerView.addSubview(lbl)
        return headerView
    }

}
//MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                 for: indexPath) as! IconTableViewCell
        cell.setContent(icons[indexPath.row])
        return cell
    }
}
//MARK: - UITableViewDelegate
extension ListViewController:   UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return self.searchBarView
        default:
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

//MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, !text.isEmpty {
            searchDataWithText(text)
        }
        else {
            getDataFromCache()
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
       
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
         searchBar.resignFirstResponder()
        getDataFromCache()
    }
}

//MARK: - KeyboardObserver
extension ListViewController {
    func observerKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc open func keyboardWillShow(_ notification: Foundation.Notification) {
        if let rectValue = (notification as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let kbRect = view.convert(rectValue.cgRectValue, from: nil)
            bottomConstraint.constant =  -1 * kbRect.size.height  + 40
        }
        
    }
    @objc open func keyboardWillHide(_ notification: Foundation.Notification) {
        bottomConstraint.constant = 0
    }
    
}
