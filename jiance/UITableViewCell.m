//
//  UITableViewCell.m
//  jiance
//
//  Created by user on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UITableViewCell.h"


@implementation UITableViewCell (UITableViewCellExt)

- (void)setBackgroundImage:(UIImage*)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    self.backgroundView = imageView;
    
}

- (void)setBackgroundImageByName:(NSString*)imageName
{
    [self setBackgroundImage:[UIImage imageNamed:imageName]];
}


@end
