//
//  FriendInviteListView.m
//  demo
//
//  Created by Rex on 2021/8/9.
//

#import "FriendInviteListView.h"

@interface FriendInviteListView() <FriendInviteViewDelegate>

@end

@implementation FriendInviteListView {
    float orgHeight;
    int lastVelocityYSign;
    BOOL isMerge;
    
    NSMutableArray *inviteViews;
}

-(id)init {
    self = [super init];
    if(self) {
        [[NSBundle mainBundle] loadNibNamed:@"FriendInviteListView" owner:self options:nil];
        [self addSubview:self.contentView];
        self.contentView.frame = self.bounds;
        [self initView];
    }
    return self;
}

-(void)initView {
    lastVelocityYSign = 0;
    isMerge = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick)];
    [self.inviteHeaderLabel setUserInteractionEnabled:YES];
    [self.inviteHeaderLabel addGestureRecognizer:tap];
    
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
//    [self addGestureRecognizer:pan];
    
    [self.scrollContentView setHidden:YES];
    
    inviteViews = [NSMutableArray new];
}

-(void)headerClick {
    isMerge = !isMerge;
    if(isMerge) {
        [self collapViews];
    } else {
        [self expandViews];
    }
    if(self.delegate != nil) {
        [self.delegate hidenInviteList:isMerge];
    }
}

-(BOOL)isInviteListHidden {
    return isMerge;
}

-(void)clearView {
    for(UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
}

-(void)setData:(NSArray *) friendItems {
    self.friendItems = friendItems;
//    NSMutableArray *array = [NSMutableArray new];
//    [array addObjectsFromArray:friendItems];
//    [array addObjectsFromArray:friendItems];
//    self.friendItems = array;
    isMerge = YES;
    [self setView];
}


-(void)setView {
    [self clearView];
    [inviteViews removeAllObjects];
    int idx=0;
    for(FriendData *friendData in self.friendItems) {
        FriendInviteView *itemView = [FriendInviteView new];
        [itemView setData:friendData];
        itemView.delegate = self;
        [self.scrollView addSubview:itemView];
        if(idx < 1) {
            itemView.frame = CGRectMake(30, 10, self.scrollView.bounds.size.width-60, 70);
        } else {
            itemView.frame = CGRectMake(40, 20, self.scrollView.bounds.size.width-80, 70);
            [self.scrollView sendSubviewToBack:itemView];
        }
        [inviteViews addObject:itemView];
        idx += 1;
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 70+10*3)];
    //[self.scrollView setScrollEnabled:NO];
}

-(void) expandViews {
    //int y=10;
    int x=30;
    int idx=0;
    int viewHeight = 70;
    int ygap = 10;
    for(UIView *view in inviteViews) {
        [UIView animateWithDuration:1.0f animations:^{
            CGFloat dy = idx * (viewHeight + ygap);
            CGFloat width = self.scrollView.frame.size.width - x * 2;
            view.frame = CGRectMake(x, dy, width, viewHeight);
        }];
        idx += 1;
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, idx*(viewHeight+ygap))];
    //[self.scrollView setScrollEnabled:YES];

}

-(void) collapViews {
    int y=10;
    int x=30;
    int idx=0;
    int viewHeight = 70;
    int ygap = 10;
    
    for(UIView *view in inviteViews) {
        [UIView animateWithDuration:1.0 animations:^{
            CGFloat dx = x;
            CGFloat dy = y;
            CGFloat width = self.scrollView.frame.size.width - x * 2;
            if(idx > 0) {
                dx += 10;
                dy = y + 10;
                width -= 10*2;
            }
            view.frame = CGRectMake(dx, dy, width, viewHeight);
        }];
        idx += 1;
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, viewHeight+ygap*3)];
    //[self.scrollView setScrollEnabled:NO];
}

//-(void)panGestureRecognizer:(UIPanGestureRecognizer *) pan {
//    CGFloat currentVelocityY = [pan velocityInView:self].y;
//    NSLog(@"velocityY=%f", currentVelocityY);
//    int currentVelocityYSign = (int)currentVelocityY > 0 ? 1 : (int)currentVelocityY == 0 ? 0 : -1;
//
//    if(currentVelocityYSign != lastVelocityYSign && currentVelocityYSign != 0) {
//        lastVelocityYSign = currentVelocityYSign;
//    }
//    if(lastVelocityYSign < 0) {
//        NSLog(@"SCROLLING DOWN");
//        if(!isMerge) {
//            isMerge = YES;
//            [self setView];
//        }
//        //[self.scrollView setContentOffset:CGPointMake(0, currentVelocityY)];
//    } else if(lastVelocityYSign > 0) {
//        NSLog(@"SCOLLING UP");
//        if(isMerge) {
//            isMerge = NO;
//            [self setView];
//        }
//    }
//}


- (void)ItemClick:(InviteType)inviteType withData:(nonnull FriendData *)data {
    if(self.delegate != nil) {
        [self.delegate inviteClick:inviteType withData:data];
    }
}


@end
