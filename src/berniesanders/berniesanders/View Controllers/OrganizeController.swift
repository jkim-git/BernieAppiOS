import UIKit
import PureLayout

public class OrganizeController : UIViewController {
    public let webView = UIWebView()
    let urlProvider : URLProvider!
    
    public init(urlProvider: URLProvider, theme: Theme) {
        self.urlProvider = urlProvider
        
        super.init(nibName: nil, bundle: nil)
        
        tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, -4))
        tabBarItem.image = UIImage(named: "organizeTabBarIconInactive")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabBarItem.selectedImage = UIImage(named: "organizeTabBarIcon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        let activeTabBarTextAttributes = [NSFontAttributeName: theme.tabBarFont(), NSForegroundColorAttributeName: theme.tabBarActiveTextColor()]
        let inactiveTabBarTextAttributes = [NSFontAttributeName: theme.tabBarFont(), NSForegroundColorAttributeName: theme.tabBarInactiveTextColor()]
        
        tabBarItem.setTitleTextAttributes(inactiveTabBarTextAttributes, forState: .Normal)
        tabBarItem.setTitleTextAttributes(activeTabBarTextAttributes, forState: .Selected)

        title = NSLocalizedString("Organize_tabBarTitle", comment: "")
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("Organize_navigationTitle", comment: "")
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        var urlRequest = NSURLRequest(URL: self.urlProvider.bernieCrowdURL())
        self.webView.loadRequest(urlRequest)
        
        self.webView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.webView)
        self.webView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0))
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
}
