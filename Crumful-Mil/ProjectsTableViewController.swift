import UIKit

class ProjectsTableViewController: UITableViewController, UITableViewDataSource {
  
    var items = NSMutableArray()
    
    @IBOutlet var projectTableView: UITableView!
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:ProjectTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ProjectTableViewCell
        
        let project:JSON =  JSON(self.items[indexPath.row])
        
        cell.projectNameLabel?.text = project["name"].string
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let dest = segue.destinationViewController as? ProjectDetailViewController {
            if let blogIndex = tableView.indexPathForSelectedRow()?.row {
                
                let selected:JSON = JSON(self.items[blogIndex])
                
                dest.projectName = selected["name"].string!
                dest.projectId = selected["project_id"].int!
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        
        RestApiManager.sharedInstance.getProjects { json in
            let results = json["projects"]
            
            for (index: String, project: JSON) in results {
                self.items.addObject(project.object)
                dispatch_async(dispatch_get_main_queue(),{
                    self.projectTableView?.reloadData()
                    return
                })
            }
        }
    }

}
