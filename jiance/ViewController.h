//
//  ViewController.h
//  jiance
//
//  Created by user on 12-7-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UINavigationBar *navBar;
    IBOutlet UITableView *mTableView;
    UILabel *hotelName;
    NSArray *hotelArr;
    NSDictionary *hotelDic;
    UILabel *sd;
}

@property (nonatomic, strong) IBOutlet UITableView *mTableView;
@property (nonatomic, strong) NSArray *hotelArr;

@property (nonatomic, strong) NSDictionary *hotelDic;

@end
