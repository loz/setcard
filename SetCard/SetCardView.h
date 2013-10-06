//
//  SetCardView.h
//  SetCard
//
//  Created by Jonathan Lozinski on 06/10/2013.
//  Copyright (c) 2013 Jonathan Lozinski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView
@property (nonatomic) NSUInteger colour;
@property (nonatomic) NSUInteger shape;
@property (nonatomic) NSUInteger fill;
@property (nonatomic) NSUInteger count;
@property (nonatomic) BOOL faceUp;
@end
