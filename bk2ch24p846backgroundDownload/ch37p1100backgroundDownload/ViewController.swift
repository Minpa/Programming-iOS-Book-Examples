

import UIKit

class ViewController: UIViewController {

    @IBOutlet var iv : UIImageView!
    @IBOutlet var prog : UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default().addObserver(self, selector: #selector(gotPicture), name: "GotPicture", object: nil)
        NotificationCenter.default().addObserver(self, selector: #selector(gotProgress), name: "GotProgress", object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("%@", "view did appear")
        self.grabPicture()
    }
        
    @IBAction func doStart (_ sender:AnyObject!) {
        self.prog.progress = 0
        self.iv.image = nil
        let del = UIApplication.shared().delegate as! AppDelegate
        del.startDownload(self)
    }
    
    func grabPicture () {
        NSLog("%@", "grabbing picture")
        let del = UIApplication.shared().delegate as! AppDelegate
        self.iv.image = del.image
        del.image = nil
        if self.iv.image != nil {
            self.prog.progress = 1
        }
    }
    
    func gotPicture (_ n : NSNotification) {
        self.grabPicture()
    }
    
    func gotProgress (_ n : NSNotification) {
        if let ui = n.userInfo {
            if let prog = ui["progress"] as? NSNumber {
                self.prog.progress = Float(prog.doubleValue)
            }
        }
    }
    
    deinit {
        NotificationCenter.default().removeObserver(self)
    }
    
    func crash (_ sender:AnyObject?) {
        _ = sender as! String
    }


}
