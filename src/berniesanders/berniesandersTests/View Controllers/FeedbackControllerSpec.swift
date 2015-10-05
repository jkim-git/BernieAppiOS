import UIKit
import Quick
import Nimble
import berniesanders


class FeedbackFakeURLProvider : FakeURLProvider {
    
    override func feedbackFormURL() -> NSURL! {
        return NSURL(string: "http://example.com/feeeedback")
    }
}


class FeedbackControllerSpec : QuickSpec {
    var subject : FeedbackController!
    var analyticsService: FakeAnalyticsService!
    
    override func spec() {
        describe("FeedbackController") {
            beforeEach {
                self.analyticsService = FakeAnalyticsService()
                self.subject = FeedbackController(urlProvider: FeedbackFakeURLProvider(), analyticsService: self.analyticsService)
            }
            
            it("has the correct title") {
                expect(self.subject.title).to(equal("Feedback"))
            }
            
            context("When the view loads") {
                beforeEach {
                    self.subject.view.layoutSubviews()
                }
                
                it("tracks taps on the back button with the analytics service") {
                    self.subject.didMoveToParentViewController(nil)
                    
                    expect(self.analyticsService.lastCustomEventName).to(equal("Tapped 'Back' on Feedback"))
                    expect(self.analyticsService.lastCustomEventAttributes).to(beNil())
                }
                
                it("should add the webview as a subview") {
                    var subviews = self.subject.view.subviews as! [UIView]
                    
                    expect(contains(subviews, self.subject.webView)).to(beTrue())
                }
                
                it("should load the feedback google form page into a webview") {
                    expect(self.subject.webView.request!.URL).to(equal(NSURL(string: "http://example.com/feeeedback")))
                }
            }
        }
    }
}