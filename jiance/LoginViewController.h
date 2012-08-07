//
//  LoginViewController.h
//  jiance
//
//  Created by user on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientClass.h"
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>{

    IBOutlet UITextField *userField;
    
    IBOutlet UITextField *pwField;
    
    IBOutlet UIButton *loginBtn;
    

}
@property(nonatomic, strong) IBOutlet UITextField *userField;
@property(nonatomic, strong) IBOutlet UITextField *pwField;
@property(nonatomic, strong) IBOutlet UIButton *loginBtn;

-(IBAction)loginPress:(id)sender;
-(IBAction)getVerifyCode:(id)sender;

@end
