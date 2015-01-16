//
//  PicScrollController.h
//  sports
//
//  Created by linxiaolong on 15/1/14.
//  Copyright (c) 2015年 linxiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PicScrollDelegate <NSObject>
- (void)selectedImage:(int)index;
// TODU

@end


@interface PicScroView : UIView
@property (nonatomic, assign) id<PicScrollDelegate> delegate;
@property (nonatomic, assign) int delayTime;                    // the diffrence time of the image turns
@property (nonatomic, assign) BOOL isMoving;                    // if the picture turn on now

// TODU
// sometime.we can change something like transparency, size, origin to do what animation we want..

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate imageArray:(NSArray *)array;
- (void)startTurnning;
// TODU

@end
