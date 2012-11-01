//
//  Setupsimulation.m
//  Core3D-Editor
//
//  Created by CoreCode on 10.06.09.
//  Copyright 2009 CoreCode. Licensed under the MIT License.
//

#import "Setupsimulation.h"


@implementation Setupsimulation

- (id)init
{
	if ((self = [super init]))
	{
		// convenience creates pass to full screen with one default light and adds it to the scene
		RenderPass *renderPass = [RenderPass mainRenderPass];
		Light *light = [[renderPass lights] objectAtIndex:0];
		
		// setup camera
		[[renderPass camera] setAxisConfiguration:AXIS_CONFIGURATION(kZAxis, kYAxis, kXAxis)];
		[[renderPass camera] setPosition:vector3f(10, 10, 10)];
		[[renderPass camera] setRotation:vector3f(-45, 45, 0)];
		
		// setup light
		[light setPosition:vector3f(0, 30, 0)];
		[light setLightDiffuseColor:vector4f(0.9f, 0.9f, 0.9f, 1.0f)];
		[light setLightAmbientColor:vector4f(0.2f, 0.2f, 0.2f, 1.0f)];
		
		// create default shader for editor
		ShaderNode *phongNode = [[[ShaderNode alloc] initWithShader:[scene phongTextureShader]] autorelease];
		[[renderPass objects] addObject:phongNode];
		
		//globalSettings.disableVBLSync = YES;
		
		// load editor now
		dispatch_async(dispatch_get_main_queue(), ^(void)
		{
			[Editor loadEditor:self];
		});

	}
	return self;
}
@end


int main(int argc, char *argv[])
{
	return NSApplicationMain(argc, (const char **) argv);
}
