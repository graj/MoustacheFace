//
//  FaceMask.m
//  MoustacheFace
//
//  Created by Homam Hosseini on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FaceMask.h"

@implementation FaceDescriptor


/*
-(id)initWithWidthRatioOfFace:(float)widthRatioOfFace andOrigin:(MetaCALayerOrigin)origin{
    return [self initWithWidthRatioOfFace:widthRatioOfFace andOrigin:origin andXAdjuster:[FaceFeatureDescriptor faceFeatureDescriptorAdjusterIdentity] andYAdjuster:[FaceFeatureDescriptor faceFeatureDescriptorAdjusterIdentity]];
}
*/

-(id)initWithWidthRatioOfFace:
(float)widthRatioOfFace 
                    andOrigin: (MetaCALayerOrigin) origin
                 andXAdjuster:(FaceFeatureDescriptorAdjuster) xAdjuster 
                 andYAdjuster:(FaceFeatureDescriptorAdjuster) yAdjuster
{
    self = [super init];
    self.origin = origin;
    self.xAdjuster = xAdjuster;
    self.yAdjuster = yAdjuster;
    self.widthRatioOfFace = widthRatioOfFace;
    return self;
}


@synthesize widthRatioOfFace = _widthRatioOfFace;
@synthesize xAdjuster = _xAdjuster;
@synthesize yAdjuster = _yAdjuster;
//@synthesize featureLayer = _featureLayer;
@synthesize origin = _origin;

-(void)adjustLayer:(MetaCALayer *)layer withFace:(CIFaceFeature *)face transformedFaceRect:(CGRect)faceRect rectConverter:(FaceFeatureRectConverter)converter{
    CGRect layerFrame = [layer metaSetWidth:faceRect.size.width*self.widthRatioOfFace];
    [layer 
     metaSetFrameLeft:  self.xAdjuster(face,layerFrame.size, faceRect)
     Bottom:            self.yAdjuster(face,layerFrame.size, faceRect)];  
}


@end

@implementation FaceFeatureDescriptor

-(void)adjustLayer:(MetaCALayer *)layer withFace:(CIFaceFeature *)face transformedFaceRect:(CGRect)faceRect rectConverter:(FaceFeatureRectConverter)converter{
    [layer metaSetWidth:faceRect.size.width*self.widthRatioOfFace andFlip:YES];
    [layer 
     metaSetFrameCenterX:self.xAdjuster(face, layer.frame.size, faceRect) 
     Y:self.yAdjuster(face, layer.frame.size, faceRect)];
    layer.frame = converter(layer.frame);
}


@end