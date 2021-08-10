//
//  FriendTabView.m
//  demo
//
//  Created by Rex on 2021/8/9.
//

#import "FriendTabView.h"


@implementation FriendTabView {
    NSLayoutConstraint *friendCountViewWidth;
    NSLayoutConstraint *talkCountViewWidth;
}

-(id)init {
    self = [super init];
    if(self) {
        [[NSBundle mainBundle] loadNibNamed:@"FriendTabView" owner:self options:nil];
        [self addSubview:self.contentView];
        self.contentView.frame = self.bounds;
        [self initView];
    }
    return self;
}

-(void)layoutSubviews {
    [self.friendInd.layer setCornerRadius:2];
    [self.talkInd.layer setCornerRadius:2];
    
}

-(void)initView {
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnclick:)];
    [self.friendTab setUserInteractionEnabled:YES];
    [self.friendTab addGestureRecognizer:tap5];

    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnclick:)];
    [self.talkTab setUserInteractionEnabled:YES];
    [self.talkTab addGestureRecognizer:tap6];
    
    [self.friendInd setHidden:NO];
    [self.talkInd setHidden:YES];

    self.friendCountView = [CountLabel new];
    [self.friendCountView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.friendCountView];
    [[[self.friendCountView topAnchor] constraintEqualToAnchor:[self.contentView topAnchor] constant:4] setActive:YES];
    [[[self.friendCountView leadingAnchor] constraintEqualToAnchor:[self.friendTab trailingAnchor]] setActive:YES];
    [[[self.friendCountView heightAnchor] constraintEqualToConstant:18] setActive:YES];
    friendCountViewWidth = [[self.friendCountView widthAnchor] constraintEqualToConstant:18];
    [friendCountViewWidth setActive:YES];
    [self.friendCountView setHidden:YES];
    
    self.talkCountView = [CountLabel new];
    [self.talkCountView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.talkCountView];
    [[[self.talkCountView topAnchor] constraintEqualToAnchor:[self.contentView topAnchor] constant:4] setActive:YES];
    [[[self.talkCountView leadingAnchor] constraintEqualToAnchor:[self.talkTab trailingAnchor]] setActive:YES];
    [[[self.talkCountView heightAnchor] constraintEqualToConstant:18] setActive:YES];
    talkCountViewWidth = [[self.talkCountView widthAnchor] constraintEqualToConstant:18];
    [talkCountViewWidth setActive:YES];
    [self.talkCountView setHidden:YES];
}

-(void)setFriendCountValue:(NSInteger) count {
    if(count == 0) {
        [self.friendCountView setHidden:YES];
        return;
    }
    NSString *cStr;
    if(count > 99) {
        cStr = @"99+";
    } else {
        cStr = [NSString stringWithFormat:@"%ld", count];
    }
    UILabel *label = [UILabel new];
    label.text = cStr;
    [label sizeToFit];
    self.friendCountView.value.text = cStr;
    friendCountViewWidth.constant = label.bounds.size.width + 10;
    [self.friendCountView setHidden:NO];
    
    [self.friendCountView setNeedsLayout];
}

-(void)setTalkCountValue:(NSInteger) count {
    if(count == 0) {
        [self.talkCountView setHidden:YES];
        return;
    }
    NSString *cStr;
    if(count > 99) {
        cStr = @"99+";
    } else {
        cStr = [NSString stringWithFormat:@"%ld", count];
    }
    UILabel *label = [UILabel new];
    label.text = cStr;
    [label sizeToFit];
    self.talkCountView.value.text = cStr;
    talkCountViewWidth.constant = label.bounds.size.width + 10;
    [self.talkCountView setHidden:NO];

    [self.talkCountView setNeedsLayout];
    
}

-(void)btnclick:(UIGestureRecognizer *)recognizer {
    UIView *view =  recognizer.view;
    [self.friendInd setHidden:YES];
    [self.talkInd setHidden:YES];
    if(self.delegate != nil) {
        
        if([view isEqual:self.friendTab]) {
            [self.friendInd setHidden:NO];
            [self.delegate tabBtnClick:FRIEND];
        } else if([view isEqual:self.talkTab]) {
            [self.talkInd setHidden:NO];
            [self.delegate tabBtnClick:TALK];
        }
        
    }
}


@end
