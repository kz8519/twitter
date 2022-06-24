//
//  ProfileViewController.h
//  twitter
//
//  Created by Kathy Zhong on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (nonatomic, strong) User *user;

@end

NS_ASSUME_NONNULL_END
