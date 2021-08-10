//
//  FriendInviteView.m
//  demo
//
//  Created by Rex on 2021/8/9.
//

#import "FriendInviteView.h"

@implementation FriendInviteView

-(id)init {
    self = [super init];
    if(self) {
        [[NSBundle mainBundle] loadNibNamed:@"FriendInviteView" owner:self options:nil];
        [self addSubview:self.contentView];
        self.contentView.frame = self.bounds;
        [self initView];
    }
    return self;
}

-(void)layoutSubviews {
    [self.contentView.layer setCornerRadius:6];
    
    [self.contentView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.contentView.layer setShadowRadius:2];
    [self.contentView.layer setShadowOpacity:0.1];
    [self.contentView.layer setShadowColor:[UIColor blackColor].CGColor];
}

-(void)initView {
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];
    [self.agreeBtn setUserInteractionEnabled:YES];
    [self.agreeBtn addGestureRecognizer:tap1];

    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];
    [self.deleteBtn setUserInteractionEnabled:YES];
    [self.deleteBtn addGestureRecognizer:tap2];
}

-(void)setData:(FriendData *)data {
    self.friendData = data;
    self.name.text = data.name;
}

-(void)itemClick:(UIGestureRecognizer *) gesture {
    UIView *view = gesture.view;
    if(self.delegate != nil) {
        if([view isEqual:self.agreeBtn]) {
            [self.delegate ItemClick:AGREE withData:self.friendData];
        } else if([view isEqual:self.deleteBtn]) {
            [self.delegate ItemClick:DELETE withData:self.friendData];
        }
    }
}

@end
