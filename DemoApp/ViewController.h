//
//  ViewController.h
//  DemoApp
//

//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    
    // array to store the latest values to be fetched from the server
    NSArray *arrayLatestValues;
}

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) IBOutlet UITableView *tableViewUserInfo;


//method to fetch data and assign it to the array.
- (void)fetchedData:(NSData *)responseData;
@end
