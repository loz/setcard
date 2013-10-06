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
@synthesize count = _count;

-(NSUInteger)count {
    if (!_count) _count = 1;
    return _count;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:CARD_RADIUS];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    [self drawShapes];
}

#pragma mark - Positioning
-(void)drawShapes {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //center vertically
    CGContextTranslateCTM(context, 0.0,
                          self.bounds.size.height / 2);
    CGFloat offset = 1.0 / (self.count + 1); //divide into sections per shape
    CGFloat spacing = self.bounds.size.width * offset;
    for(int x=1; x<= self.count; x++) {
        CGContextTranslateCTM(context, spacing, 0.0);
        [self drawShape];
    }
    CGContextRestoreGState(context);
}

#pragma mark - Shape Draw Routines
-(void)drawShape {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //Center
    CGContextTranslateCTM(context, [self shapeWidth] * -0.5,
                                   [self shapeHeight] * -0.5);
    UIBezierPath *shape;
    switch (self.shape) {
        case 0:
            shape = [self diamondShape];
            break;
        case 1:
            shape = [self ovalShape];
            break;
        case 2:
            shape = [self squiggleShape];
            break;
    }
    
    //Color
    UIColor *colour = [self shapeColour];
    [colour setStroke];
    [colour setFill];
    shape.lineWidth = 2.5;
    [shape stroke];
    
    //Shading
    [self shadeShape:shape];
    CGContextRestoreGState(context);
}

-(void)shadeShape:(UIBezierPath *)shape {
    switch (self.fill) {
        case 0:
            [shape fill];
            break;
        case 1:
            //Outline, nothing to do
            break;
        case 2:
            //Shaded
            [shape addClip];
            for (int x=0; x <=5; x++) {
                CGFloat xpos = (0.2 * x) * [self shapeWidth];
                UIBezierPath *line = [UIBezierPath bezierPath];
                [line moveToPoint:CGPointMake(xpos, 0.0)];
                [line addLineToPoint:CGPointMake(xpos, [self shapeHeight])];
                line.lineWidth = 2.5;
                [line stroke];
            }
            break;
    }
}

-(UIColor *)shapeColour {
    switch (self.colour) {
        case 0: //Red
            return [UIColor colorWithRed:0.85 green:0.00 blue:0.0 alpha:1.0];
            break;
        case 1: //Green
            return [UIColor colorWithRed:0.0 green:0.75 blue:0.0 alpha:1.0];
            break;
        case 2: //Purple
            return [UIColor colorWithRed:0.75 green:0.00 blue:0.85 alpha:1.0];
            break;
    }
    return [UIColor whiteColor];
}

-(UIBezierPath *)ovalShape {
    UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:[self shapeRect]
                                                    cornerRadius:[self shapeWidth]];
    return oval;
}

-(UIBezierPath *)diamondShape {
    UIBezierPath *diamond = [[UIBezierPath alloc] init];
    [diamond moveToPoint:CGPointMake([self shapeWidth] / 2.0, 0.0)];
    [diamond addLineToPoint:CGPointMake([self shapeWidth], [self shapeHeight] / 2.0)];
    [diamond addLineToPoint:CGPointMake([self shapeWidth] / 2.0, [self shapeHeight])];
    [diamond addLineToPoint:CGPointMake(0.0, [self shapeHeight] / 2.0)];
    [diamond closePath];
    return diamond;
}

-(UIBezierPath *)squiggleShape {
    UIBezierPath *squiggle = [[UIBezierPath alloc] init];
    /*   a
       f_\\_b
       e_//_c
         \\
          d
    */
    
    //a
    [squiggle moveToPoint:CGPointMake([self shapeWidth] * 0.25,
                                      [self shapeHeight] * 0.00)];
    
    //a-b
    [squiggle addQuadCurveToPoint:CGPointMake([self shapeWidth] * 1.00,
                                              [self shapeHeight] * 0.25)
                     controlPoint:CGPointMake([self shapeWidth] * 0.90,
                                              [self shapeHeight] * 0.00)];
    
    //b-c
    [squiggle addCurveToPoint:CGPointMake([self shapeWidth] * 0.90,
                                          [self shapeHeight] * 0.75)
                controlPoint1:CGPointMake([self shapeWidth] * 1.20,
                                          [self shapeHeight] * 0.50)
                controlPoint2:CGPointMake([self shapeWidth] * 0.60,
                                          [self shapeHeight] * 0.50)];
    
    //c-d
    [squiggle addQuadCurveToPoint:CGPointMake([self shapeWidth] * 0.75,
                                              [self shapeHeight] * 1.00)
                     controlPoint:CGPointMake([self shapeWidth] * 1.25,
                                              [self shapeHeight] * 1.00)];
    
    //d-e
    [squiggle addQuadCurveToPoint:CGPointMake([self shapeWidth] * 0.00,
                                              [self shapeHeight] * 0.75)
                     controlPoint:CGPointMake([self shapeWidth] * 0.10,
                                              [self shapeHeight] * 1.00)];
    
    //e-f
    [squiggle addCurveToPoint:CGPointMake([self shapeWidth] * 0.10,
                                          [self shapeHeight] * 0.25)
                controlPoint1:CGPointMake([self shapeWidth] * -0.10,
                                          [self shapeHeight] * 0.50)
                controlPoint2:CGPointMake([self shapeWidth] * 0.40,
                                          [self shapeHeight] * 0.50)];
    
    //f-a
    [squiggle addQuadCurveToPoint:CGPointMake([self shapeWidth] * 0.25,
                                              [self shapeHeight] * 0.00)
                     controlPoint:CGPointMake([self shapeWidth] * -0.25,
                                              [self shapeHeight] * 0.00)];
    [squiggle closePath];
    return squiggle;
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
