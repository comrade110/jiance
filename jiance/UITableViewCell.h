//
//  UITableViewCell.h
//  jiance
//
//  Created by user on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableViewCell (UITableViewCellExt)

- (void)setBackgroundImage:(UIImage*)image;
- (void)setBackgroundImageByName:(NSString*)imageName;

@end