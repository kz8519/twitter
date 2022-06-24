//
//  ReplyViewController.h
//  twitter
//
//  Created by Kathy Zhong on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ReplyViewControllerDelegate

- (void)didReply:(Tweet *)tweet;

@end

@interface ReplyViewController : UIViewController
@property (nonatomic, weak) id<ReplyViewControllerDelegate> delegate;
@property (nonatomic, strong) Tweet *tweet; // For favoriting, retweeting & replying


@end

NS_ASSUME_NONNULL_END
