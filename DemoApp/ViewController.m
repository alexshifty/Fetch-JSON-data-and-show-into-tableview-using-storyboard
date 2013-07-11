//
//  ViewController.m
//  DemoApp
//

//



#import "ViewController.h"
#import "UserDetailsCell.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@end
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) 
#define kJSONURL [NSURL URLWithString:@"https://alpha-api.app.net/stream/0/users/1/posts"]

@implementation ViewController
@synthesize activityIndicator;
@synthesize tableViewUserInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.activityIndicator startAnimating];
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        kJSONURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    
    
}

//to fetch data from the server and store it into the array
- (void)fetchedData:(NSData *)responseData {
    
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    arrayLatestValues = [json objectForKey:@"data"]; //2
    
    NSLog(@"loans: %@", arrayLatestValues); //3
    
    [self.tableViewUserInfo reloadData];
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidesWhenStopped:YES];
    
}


//UITableViewDataSource delegate method to define number of rows within a section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayLatestValues count];
}


//UITableViewDataSource delegate method to assign values to every cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"userDetailCell";
    
    UserDetailsCell *cell = [self.tableViewUserInfo dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *userDict = [arrayLatestValues objectAtIndex:indexPath.row];
    
    NSURL *imageUrl = [NSURL URLWithString:[[[userDict valueForKey:@"user"] valueForKey:@"avatar_image"] valueForKey:@"url"]];
    
    [cell.userImage setImageWithURL:imageUrl];
    
    cell.userName.text = [[userDict valueForKey:@"user"] valueForKey:@"username"];
    
    [cell.userText loadHTMLString:[userDict valueForKey:@"html"] baseURL:nil];
    

    
    NSLog(@"%d %@", indexPath.row, cell.userName.text);
    
    return cell;
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
