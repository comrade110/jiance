//
//  PZViewController.h
//  jiance
//
//  Created by user on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientClass.h"
#import "SOAPXMlParse.h"

@interface PZViewController : UIViewController<UIScrollViewDelegate>{
    
    NSString *hid;
    IBOutlet UIScrollView *sview;
    IBOutlet UIView *view1;
    IBOutlet UITextView *textView;
    
    
}
@property(nonatomic, strong) IBOutlet UIScrollView *sview;
@property(nonatomic, strong) IBOutlet UIView *view1;
@property(nonatomic, strong) IBOutlet UILabel *label1;
@property(nonatomic, strong) IBOutlet UILabel *label2;
@property(nonatomic, strong) IBOutlet UILabel *label3;
@property(nonatomic, strong) IBOutlet UILabel *label4;
@property(nonatomic, strong) IBOutlet UILabel *label5;
@property(nonatomic, strong) IBOutlet UILabel *label6;
@property(nonatomic, strong) IBOutlet UILabel *label7;
@property(nonatomic, strong) IBOutlet UILabel *label8;
@property(nonatomic, strong) IBOutlet UILabel *label9;
@property(nonatomic, strong) IBOutlet UILabel *label10;
@property(nonatomic, strong) IBOutlet UILabel *label11;
@property(nonatomic, strong) IBOutlet UILabel *label12;
@property(nonatomic, strong) IBOutlet UILabel *label13;
@property(nonatomic, strong) IBOutlet UILabel *label14;
@property(nonatomic, strong) IBOutlet UILabel *label15;
@property(nonatomic, strong) IBOutlet UILabel *label16;
@property(nonatomic, strong) IBOutlet UILabel *label17;
@property(nonatomic, strong) IBOutlet UITextView *textView;


@end
