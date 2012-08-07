//
//  JBViewController.h
//  jiance
//
//  Created by user on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientClass.h"
#import "SOAPXMlParse.h"
#import "MBProgressHUD.h"

@interface JBViewController : UIViewController{

    NSString *hid;
    
    NSString *allstr;

}


@property(nonatomic,retain) IBOutlet UIWebView *logWV;

@end
