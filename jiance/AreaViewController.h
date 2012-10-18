//
//  AreaViewController.h
//  jiance
//
//  Created by user on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientClass.h"
#import "SOAPXMlParse.h"
#import "MBProgressHUD.h"
#import "UITableViewCell.h"

@interface AreaViewController : UITableViewController{
    
    NSArray *pArr;
    NSArray *sgArr;
    NSString *sgStr;
    SOAPXMlParse *sxp;
    

}
@property(nonatomic,strong) NSArray *sgArr;


@end
