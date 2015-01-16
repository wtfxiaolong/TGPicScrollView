//
//  PicScrollController.m
//  sports
//
//  Created by linxiaolong on 15/1/14.
//  Copyright (c) 2015年 linxiaolong. All rights reserved.
//

#import "PicScroView.h"


#define RECTX  self.rect.size.width
#define RECTY self.rect.size.height
#define Banner_StartTag     1000

@interface PicScroView () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic) int curPageIndex;
@property (nonatomic) CGRect rect;
@property (nonatomic, strong) NSArray *imgArray;

@end

@implementation PicScroView

- (void)testView {
    self.backgroundColor = [UIColor whiteColor];
    self.rect = CGRectMake(0, 20, RECTX, RECTY/4);
    
}

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate imageArray:(NSArray *)array {
    self = [super initWithFrame:frame];
    if (self) {
        if (array.count < 1 || array == nil) {
            return nil;
        }
        self.rect = frame;
        self.imgArray = array;
        self.delegate = delegate;
        self.curPageIndex = 0;
        self.delayTime = 3;
        self.isMoving = YES;
        
        self.backgroundColor = [UIColor blackColor];
        
        // set the scrollView
        CGRect scrollViewRect = CGRectMake( 0.f, 0.f, RECTX, RECTY);
        self.scrollView = [[UIScrollView alloc] initWithFrame: scrollViewRect];
        [self.scrollView setContentSize:CGSizeMake(RECTX*3, RECTY)];
        [self.scrollView setDelegate:self];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        
        // add three views
        for (int i = 0; i<3; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectOffset(self.scrollView.bounds, RECTX * i, 0)];
            imageView.userInteractionEnabled = YES;
            imageView.tag = Banner_StartTag + i;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
            [imageView addGestureRecognizer:tapGesture];
            [self.scrollView addSubview:imageView];
        }
        
        // TODU
        // set the pageCtol if you need
        
    }
    
    return self;
}

#pragma mark - set the dataSource

- (void)startTurnning {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_delayTime target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    [timer fire];
}

#pragma mark - add three views, and every view will be replaced
- (void)refreshScrollView
{
    for (int i=0; i<3; i++) {
        UIImageView *iamgeView = (UIImageView *)[self.scrollView viewWithTag:Banner_StartTag + i];
        int index = [self getValidPageIndex:(int)(self.curPageIndex-1+i)];
        iamgeView.image = [UIImage imageNamed:self.imgArray[index]];
    }
    [_scrollView setContentOffset:CGPointMake(RECTX, 0)];
}

- (int)getValidPageIndex:(int)index {
    if (index == -1) {
        return (int)(self.imgArray.count-1);
    } else if (index == self.imgArray.count) {
        return 0;
    } else {
        return index;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.curPageIndex = [self getValidPageIndex:self.curPageIndex + 1];
        [self refreshScrollView];
    }
    if(contentOffsetX <= 0) {
        self.curPageIndex = [self getValidPageIndex:self.curPageIndex - 1];
        [self refreshScrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // append the half of the picture
    [scrollView setContentOffset:CGPointMake(RECTX, 0) animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isMoving = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.isMoving = YES;
}

#pragma mark - Animation Timer

- (void)scrollTimer {
    if (self.isMoving) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.scrollView setContentOffset:CGPointMake(2*RECTX, 0) animated:YES];
        } completion:^(BOOL finished) {
            // TODO
        }];
    }
}

#pragma mark - Actions

- (void)contentViewTapAction:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"tap..%d", self.curPageIndex);
    if ([self.delegate respondsToSelector:@selector(selectedImage:)]) {
        [self.delegate selectedImage:self.curPageIndex];
    }
}
    

@end
