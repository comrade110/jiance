//
//  LoginViewController.m
//  jiance
//
//  Created by user on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "iToast.h"
#import "SOAPXMlParse.h"
#import "AreaViewController.h"


@implementation LoginViewController

@synthesize userField,pwField,loginBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userField.delegate = self;
    
    pwField.delegate = self;
    
    self.navigationItem.title = @"云和数据监控中心";
	// Do any additional setup after loading the view.
}

-(void)loginHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *result = (NSString*)value;
    
    NSLog(@"%@",result);
    CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:result options:0 error:nil];
    
    SOAPXMlParse *sxp = [[SOAPXMlParse alloc] init];
    
    NSArray *tempArr = [sxp parseDire2:document nodeName:@"//root"];
    
    NSDictionary *tempDicF = [tempArr objectAtIndex:0];
    
    NSDictionary *tempDic = [tempDicF objectForKey:@"root"];
    
    if ([tempDic objectForKey:@"sessionid"] != nil) {
        
        NSLog(@"%@",[tempDic objectForKey:@"sessionid"]);
        [[iToast makeText:@"登录成功"] show];
        UIStoryboard*  sb;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad"
                                           bundle:nil];
        }else {
            sb =[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                          bundle:nil];
        }
        
        
        AreaViewController *areaViewController = [sb instantiateViewControllerWithIdentifier:@"AreaViewController"];
        // ...
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:areaViewController animated:YES];
    }
    else {
        
        [[[iToast makeText:@"登录失败！"] setDuration:5000] show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
            




}



- (void)viewDidUnload
{
    [super viewDidUnload];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    // Release any retained subviews of the main view.
}



-(void)getLoginCodeHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    
    NSString *result = (NSString*)value;
    
    NSLog(@"%@",result);
    CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:result options:0 error:nil];
    
    SOAPXMlParse *sxp = [[SOAPXMlParse alloc] init];
    
    NSArray* tempArr = [sxp parseDire2:document nodeName:@"//root"];
    
    NSString *temp = [[[tempArr objectAtIndex:0] objectForKey:@"root"] objectForKey:@"code"]; 
    
    switch ([temp intValue]) {
        case -1:
            [[iToast makeText:@"未登录"] show];
            break;
        case -2:
            [[iToast makeText:@"无权限查看该酒店"] show];
            break;
        case -3:
            [[iToast makeText:@"用户名或密码错误"] show];
            break;
        case -4:
            [[iToast makeText:@"帐户在非启用时间登录"] show];
            break;
        case -5:
            [[iToast makeText:@"帐号已禁用"] show];
            break;
        case -6:
            [[iToast makeText:@"未找到该手机帐号"] show];
            break;
        case -7:
            [[iToast makeText:@"登录码错误"] show];
            break;
            
        default:
            break;
    }
}

// 获取验证码

-(IBAction)getVerifyCode:(id)sender{
    NSLog(@"%@",userField.text);

    [[ClientClass sharedService] getLoginCode:self action:@selector(getLoginCodeHandler:) phone:userField.text];
    
}



// 点击登录

-(IBAction)loginPress:(id)sender{
    
    [[ClientClass sharedService] login:self action:@selector(loginHandler:) phone:userField.text psw:pwField.text type:2];
}


// 点击textField VIEW上移
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (userField == textField) {
        
        [UIView beginAnimations:@"ani" context:nil];
        [UIView setAnimationDuration:0.3];
        self.view.frame = CGRectMake(0, -userField.frame.origin.y+20,320,460);
        [UIView commitAnimations];
        
    }
    if (pwField == textField) {
        
        [UIView beginAnimations:@"ani" context:nil];
        [UIView setAnimationDuration:0.3];
        self.view.frame = CGRectMake(0, -pwField.frame.origin.y+70,320,460);
        [UIView commitAnimations];
        
    }


}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    [UIView beginAnimations:@"ani2" context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0,0,320,460);
    [UIView commitAnimations];
    return YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}



@end
