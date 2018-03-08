//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Developer 1 on 07/03/18.
//  Copyright © 2018 DyCode. All rights reserved.
//

import UIKit

struct Movie{
    var title: String = ""
    var year: Int = 0
}

class TableViewController: UIViewController {
    @IBOutlet weak var tableview_MoviesList: UITableView!
    weak var refreshControl : UIRefreshControl!
    
    var movieList: [Movie] = [
        Movie(title: "TOMB RAIDER", year: 2018),
        Movie(title: "BLACK PANTHER", year: 2018),
        Movie(title: "THE POST", year: 2018),
        Movie(title: "THE LODGERS", year: 2018),
        Movie(title: "EARLY MAN", year: 2018),
        Movie(title: "PETER RABBIT", year: 2018),
        Movie(title: "RED SPARROW", year: 2018),
        Movie(title: "BENYAMIN BIANG KEROK", year: 2018),
        Movie(title: "BAYI GAIB", year: 2018),
        Movie(title: "TAKUT KAWIN", year: 2018),
        Movie(title: "DILAN", year: 2018),
        Movie(title: "YOWIS BEN", year: 2018)
    ]
    
    var unwatchedMovies: [Movie] = [Movie(title: "BENYAMIN BIANG KEROK", year: 2018),
                                    Movie(title: "BAYI GAIB", year: 2018),
                                    Movie(title: "TAKUT KAWIN", year: 2018),
                                    Movie(title: "DILAN", year: 2018),
                                    Movie(title: "YOWIS BEN", year: 2018)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableview_MoviesList.dataSource = self
        tableview_MoviesList.delegate = self
        
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(TableViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        
        tableview_MoviesList.addSubview(view)
        refreshControl = view
    }
    
    @objc func refresh(_ sender: UIRefreshControl){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
            self.refreshControl.endRefreshing()
            
            self.movieList = [
                Movie(title: "TOMB RAIDER", year: 2018),
                Movie(title: "BLACK PANTHER", year: 2018),
                Movie(title: "THE POST", year: 2018),
                Movie(title: "THE LODGERS", year: 2018),
                Movie(title: "EARLY MAN", year: 2018),
                Movie(title: "PETER RABBIT", year: 2018),
                Movie(title: "RED SPARROW", year: 2018),
                Movie(title: "BENYAMIN BIANG KEROK", year: 2018),
                Movie(title: "BAYI GAIB", year: 2018),
                Movie(title: "TAKUT KAWIN", year: 2018),
                Movie(title: "DILAN", year: 2018),
                Movie(title: "YOWIS BEN", year: 2018)
            ]
            
            self.unwatchedMovies = [Movie(title: "BENYAMIN BIANG KEROK", year: 2018),
                                    Movie(title: "BAYI GAIB", year: 2018),
                                    Movie(title: "TAKUT KAWIN", year: 2018),
                                    Movie(title: "DILAN", year: 2018),
                                    Movie(title: "YOWIS BEN", year: 2018)]
            
            self.tableview_MoviesList.reloadData()
        })
    }
}

extension TableViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return movieList.count
        }else{
            return unwatchedMovies.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview_MoviesList.dequeueReusableCell(withIdentifier: "CELL_ID", for: indexPath)
        let movie = indexPath.section == 0 ? movieList[indexPath.row] : unwatchedMovies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = String(movie.year)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "You watched"
        }else{
            return "Now playing"
        }
    }
}

extension TableViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview_MoviesList.deselectRow(at: indexPath, animated: true)
        let movie = indexPath.section == 0 ? movieList[indexPath.row] : unwatchedMovies[indexPath.row]
        let alert = UIAlertController(title: "Info", message: "\(movie.title) - \(movie.year)", preferredStyle:  UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0{
//            return UIScreen.main.bounds.width
//        }else{
//            return 60
//        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            if indexPath.section == 0{
                movieList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }else{
                unwatchedMovies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
