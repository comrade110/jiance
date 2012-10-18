//
//  KFDetailViewController.h
//  jiance
//
//  Created by user on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFDetailViewController : UITableViewController{

}
@property(nonatomic,strong) NSDictionary *kfdic;
@property(nonatomic,strong) NSArray *kfarr;
@property(nonatomic,assign) int kftabcount;
@property(nonatomic,strong) NSString *mac;
@property(nonatomic,strong) NSString *begintime;
@property(nonatomic,strong) NSString *endtime;
@end
