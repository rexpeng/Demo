//
//  ContLabel.m
//  demo
//
//  Created by Rex on 2021/8/9.
//

#import "CountLabel.h"

@implementation CountLabel


-(id)init {
    self = [super init];
    if(self) {
        [[NSBundle mainBundle] loadNibNamed:@"CountLabel" owner:self options:nil];
        [self addSubview:self.contentView];
        self.contentView.frame = self.bounds;
        //[self initView];
    }
    return self;
}

-(void)layoutSubviews {
    [self.contentView.layer setCornerRadius:9];
}

@end
