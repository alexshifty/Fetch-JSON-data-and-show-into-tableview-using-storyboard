//
//  UserDetailsCell.h
//  DemoApp
//
//

#import <UIKit/UIKit.h>

@interface UserDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIWebView *userText;

@end
