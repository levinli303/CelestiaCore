//
//  CelestiaBody.mm
//  celestia
//
//  Created by Bob Ippolito on Sat Jun 08 2002.
//  Copyright (C) 2007, Celestia Development Team
//

#import "CelestiaBody.h"
#import "CelestiaBody+Private.h"
#import "CelestiaCatEntry+Private.h"
#import "CelestiaOrbit+Private.h"
#import "CelestiaRotationModel+Private.h"
#import "CelestiaPlanetarySystem+Private.h"
#import "CelestiaUtil.h"

#include <string>
#include <vector>

@implementation CelestiaBody (Private)

- (CelestiaBody*)initWithBody:(Body *)body {
    self = [super initWithCatEntry:reinterpret_cast<CatEntry *>(body)];
    return self;
}

-(Body *)body {
    return reinterpret_cast<Body *>([self entry]);
}

@end

@implementation CelestiaBody

- (NSString *)classification
{
    switch ([self body]->getClassification())
    {
        case (Body::Planet):
            return NSLocalizedString(@"Planet",@"");
            break;
        case (Body::Moon):
            return NSLocalizedString(@"Moon",@"");
            break;
        case (Body::Asteroid):
            return NSLocalizedString(@"Asteroid",@"");
            break;
        case (Body::Comet):
            return NSLocalizedString(@"Comet",@"");
            break;
        case (Body::Spacecraft):
            return NSLocalizedString(@"Spacecraft",@"");
            break;
        default:
            break;
    }
    return NSLocalizedString(@"Unknown",@"");
}

-(NSString *)name {
    return [NSString stringWithUTF8String:[self body]->getName(true).c_str()];
}

- (float)radius {
    return [self body]->getRadius();
}

- (float)mass {
    return [self body]->getMass();
}

- (float)albedo {
    return [self body]->getAlbedo();
}

- (void)setMass:(float)m
{
    [self body]->setMass(m);
}

- (void)setAlbedo:(float)a {
    [self body]->setAlbedo(a);
}

- (NSArray<NSString *> *)alternateSurfaceNames {
    NSMutableArray *result = nil;
    std::vector<std::string> *altSurfaces = [self body]->getAlternateSurfaceNames();
    if (altSurfaces)
    {
        result = [NSMutableArray array];
        if (altSurfaces->size() > 0)
        {
            for (unsigned int i = 0; i < altSurfaces->size(); ++i)
            {
                [result addObject:[NSString stringWithUTF8String:(*altSurfaces)[i].c_str()]];
            }
        }
        delete altSurfaces;
    }
    return result;
}

- (CelestiaPlanetarySystem *)system {
    PlanetarySystem *s = [self body]->getSystem();
    if (s == NULL) {
        return nil;
    }
    return [[CelestiaPlanetarySystem alloc] initWithSystem:s];
}

- (NSString *)webInfoURL {
    return [NSString stringWithUTF8String:[self body]->getInfoURL().c_str()];
}

- (CelestiaOrbit *)orbitAtTime:(NSDate *)time {
    return [[CelestiaOrbit alloc] initWithOrbit:[self body]->getOrbit([time julianDay])];
}

- (CelestiaRotationModel *)rotationAtTime:(NSDate *)time {
    return [[CelestiaRotationModel alloc] initWithRotation:[self body]->getRotationModel([time julianDay])];
}

@end
