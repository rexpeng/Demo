//
//  NavigateView.m
//  demo
//
//  Created by Rex on 2021/8/9.
//

#import "NavigateView.h"

@implementation NavigateView

-(id)init {
    self = [super init];
    if(self) {
        [[NSBundle mainBundle] loadNibNamed:@"NavigateView" owner:self options:nil];
        [self addSubview:self.contentView];
        self.contentView.frame = self.bounds;
        [self initView];
    }
    return self;
}

-(void)initView {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnclick:)];
    [self.withdrawBtn setUserInteractionEnabled:YES];
    [self.withdrawBtn addGestureRecognizer:tap];

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnclick:)];
    [self.transferBtn setUserInteractionEnabled:YES];
    [self.transferBtn addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnclick:)];
    [self.scanBtn setUserInteractionEnabled:YES];
    [self.scanBtn addGestureRecognizer:tap2];

    
}

-(void)btnclick:(UITapGestureRecognizer *) recognizer {
    UIView *view =  recognizer.view;
    if(self.delegate != nil) {
    
        if([view isEqual:self.scanBtn]) {
            [self.delegate naviBtnClick:SCAN];
        } else if([view isEqual:self.withdrawBtn]) {
            [self.delegate naviBtnClick:WITHDRAW];
        } else if([view isEqual:self.transferBtn]) {
            [self.delegate naviBtnClick:TRANSFER];
        }
    }

}
@end
