//
//  KFViewController.h
//  jiance
//
//  Created by user on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientClass.h"
#import "SOAPXMlParse.h"
#import "MBProgressHUD.h"

@interface KFViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    NSString *hid;
    NSString *stodate;
    NSString *etodate;
    UINavigationBar *nav;
    UIDatePicker *dp;
    NSArray* tempArr;
}

@property(nonatomic, retain) IBOutlet UITableView *tView;

@property(nonatomic,retain) IBOutlet UITextView *roomInfo;

@property(nonatomic,retain) IBOutlet UIButton *startBtn;

@property(nonatomic,retain) IBOutlet UIButton *endBtn;

@property(nonatomic,retain) IBOutlet UIButton *searchBtn;

@property(nonatomic,retain) IBOutlet UIButton *resetBtn;

@property(nonatomic,retain) IBOutlet UILabel *startTime;

@property(nonatomic,retain) IBOutlet UILabel *endTime;


-(IBAction)startTimeBtnPress:(id)sender;

-(IBAction)endTimeBtnPress:(id)sender;

-(IBAction)resetTime:(id)sender;

-(IBAction)searchKFData:(id)sender;

@end
