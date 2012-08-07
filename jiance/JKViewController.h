//
//  JKViewController.h
//  jiance
//
//  Created by user on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientClass.h"
#import "SOAPXMlParse.h"

@interface JKViewController : UIViewController{

    IBOutlet UILabel *myTitle;
    
    NSString *mid;

}
@property(nonatomic, retain) IBOutlet UILabel *myTitle;
@property(nonatomic, retain) IBOutlet UILabel *cpu;
@property(nonatomic, retain) IBOutlet UILabel *usemen;
@property(nonatomic, retain) IBOutlet UILabel *disk;
@property(nonatomic, retain) IBOutlet UILabel *nis;


-(IBAction)reflashData:(id)sender;

@end
