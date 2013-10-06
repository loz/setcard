//
//  SetCardView.m
//  SetCard
//
//  Created by Jonathan Lozinski on 06/10/2013.
//  Copyright (c) 2013 Jonathan Lozinski. All rights reserved.
//

#import "SetCardView.h"

#define CARD_RADIUS 15.0
#define SHAPE_X_RATIO 0.15
#define SHAPE_Y_RATIO 0.70

@implementation SetCardView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:CARD_RADIUS];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    [self setDrawStroke];
    [self setDrawFill];;
    [self drawShape];
}

#pragma mark - Shape Draw Routines
-(void)drawShape {
    switch (self.shape) {
        case 0:
            [self drawDiamond];
            break;
        case 1:
            [self drawOval];
            break;
        case 2:
            [self drawSquiggle];
            break;
    }
}

-(void)setDrawStroke {
    
}

-(void)setDrawFill {
    [[UIColor blueColor] setFill];
    switch (self.colour) {
        case 0:
            [[UIColor redColor] setFill];
            break;
        case 1:
            [[UIColor greenColor] setFill];
            break;
        case 2:
            [[UIColor purpleColor] setFill];
            break;
    }
}

-(void)drawOval {
    UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:[self shapeRect]];
    [oval fill];
}

-(void)drawDiamond {
    UIBezierPath *diamond = [[UIBezierPath alloc] init];
    [diamond moveToPoint:CGPointMake([self shapeWidth] / 2.0, 0.0)];
    [diamond addLineToPoint:CGPointMake([self shapeWidth], [self shapeHeight] / 2.0)];
    [diamond addLineToPoint:CGPointMake([self shapeWidth] / 2.0, [self shapeHeight])];
    [diamond addLineToPoint:CGPointMake(0.0, [self shapeHeight] / 2.0)];
    [diamond closePath];
    [diamond fill];
}

-(void)drawSquiggle {
    UIBezierPath *squiggle = [[UIBezierPath alloc] init];
    [squiggle moveToPoint:CGPointMake(0.0, 0.0)];
    [squiggle addQuadCurveToPoint:CGPointMake([self shapeWidth],
                                         [self shapeHeight] * 0.3)
                controlPoint:[self shapeTopRight]];
    //[squiggle addQuadCurveToPoint:CGPointMake([self shapeWidth] * 0.8,
    //                                     [self shapeHeight] * 0.7)
    //            controlPoint:[self shapeTopRight]];
    [squiggle addQuadCurveToPoint:CGPointMake([self shapeWidth],
                                         [self shapeHeight])
                controlPoint:[self shapeBottomLeft]];
    [squiggle addQuadCurveToPoint:CGPointMake(0.0,
                                         [self shapeHeight] * 0.7)
                controlPoint:[self shapeBottomLeft]];
    [squiggle addQuadCurveToPoint:CGPointMake([self shapeWidth] * 0.2,
                                         [self shapeHeight] * 0.3)
                controlPoint:[self shapeBottomLeft]];
    [squiggle addQuadCurveToPoint:CGPointMake(0.0,
                                              0.0)
                     controlPoint:[self shapeBottomLeft]];
    [squiggle closePath];
    [squiggle fill];
}

-(CGPoint)shapeTopRight {
    return CGPointMake([self shapeWidth], 0.0);
}
-(CGPoint)shapeBottomRight {
    return CGPointMake([self shapeWidth], [self shapeHeight]);
}
-(CGPoint)shapeTopLeft {
    return CGPointMake(0.0, 0.0);
}
-(CGPoint)shapeBottomLeft {
    return CGPointMake(0.0, [self shapeHeight]);
}
     
-(CGFloat)shapeWidth {
    return self.bounds.size.width * SHAPE_X_RATIO;
}

-(CGFloat)shapeHeight {
    return self.bounds.size.height * SHAPE_Y_RATIO;
}

-(CGRect)shapeRect {
    return CGRectMake(0.0, 0.0,
                      [self shapeWidth],
                      [self shapeHeight]);

}

#pragma mark - Setters

-(void)setColour:(NSUInteger)colour {
    _colour = colour;
    [self setNeedsDisplay];
}

-(void)setFill:(NSUInteger)fill {
    _fill = fill;
    [self setNeedsDisplay];
}

-(void)setShape:(NSUInteger)shape {
    _shape = shape;
    [self setNeedsDisplay];
}

-(void)setCount:(NSUInteger)count {
    _count = count;
    [self setNeedsDisplay];
}

-(void)setFaceUp:(BOOL)faceUp {
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

#pragma mark - Initialization
-(void)setup {
    //do setup
}

-(void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
