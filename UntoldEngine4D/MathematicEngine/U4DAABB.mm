//
//  U4DAABB.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 2/28/16.
//  Copyright © 2016 Untold Engine Studios. All rights reserved.
//

#include "U4DAABB.h"
#include "U4DSphere.h"
#include "U4DSegment.h"
#include "U4DTriangle.h"
#include "U4DPlane.h"
#include <cmath>
#include "Constants.h"

namespace U4DEngine {

    U4DAABB::U4DAABB(){
        
        minPoint.zero();
        maxPoint.zero();
        longestAABBDimensionVector.zero();
        
    }
    
    U4DAABB::~U4DAABB(){
        
    }
    
    U4DAABB::U4DAABB(U4DPoint3n &uMinPoint, U4DPoint3n &uMaxPoint){
        
        minPoint=uMinPoint;
        maxPoint=uMaxPoint;
        
    }
    
    U4DAABB::U4DAABB(float uX, float uY, float uZ, U4DPoint3n &uCenter){
        
        U4DVector3n halfwidth(uX, uY, uZ);
        
        maxPoint=uCenter+halfwidth.toPoint();
        minPoint=(halfwidth.toPoint()-uCenter).toPoint();
        
    }
    
    U4DAABB::U4DAABB(const U4DAABB& a):minPoint(a.minPoint),maxPoint(a.maxPoint){
        
    }
    
    
    U4DAABB& U4DAABB::operator=(const U4DAABB& a){
        
        minPoint=a.minPoint;
        maxPoint=a.maxPoint;
        
        return *this;
    }
    
    U4DPoint3n U4DAABB::getCenter(){
        
        return (maxPoint+minPoint)*0.5;
        
    }
    
    void U4DAABB::setMinPoint(U4DPoint3n& uMinPoint){
        
        minPoint=uMinPoint;
    }
    
    void U4DAABB::setMaxPoint(U4DPoint3n& uMaxPoint){
        
        maxPoint=uMaxPoint;
        
    }
    
    U4DPoint3n U4DAABB::getMinPoint(){
        return minPoint;
    }
    
    U4DPoint3n U4DAABB::getMaxPoint(){
        return maxPoint;
    }
    
    
    bool U4DAABB::intersectionWithVolume(U4DAABB *uAABB){
        
        //Exit with no intersection if separated along an axis
        
        if (maxPoint.x<uAABB->minPoint.x || minPoint.x>uAABB->maxPoint.x) return false;
        if (maxPoint.y<uAABB->minPoint.y || minPoint.y>uAABB->maxPoint.y) return false;
        if (maxPoint.z<uAABB->minPoint.z || minPoint.z>uAABB->maxPoint.z) return false;
        
        //overlapping on all axes means AABBs are intersecting
        
        return true;
    }
    
    float U4DAABB::squareDistanceToPoint(U4DPoint3n& uPoint){
        float sqDistance=0.0;
        
        //for each axix count any excess distance outside box extents. See page 131 in Real-Time Collision Detection
        
        //x-axis
        if (uPoint.x<minPoint.x) sqDistance+=(minPoint.x-uPoint.x)*(minPoint.x-uPoint.x);
        if (uPoint.x>maxPoint.x) sqDistance+=(uPoint.x-maxPoint.x)*(uPoint.x-maxPoint.x);
        
        
        //y-axis
        if (uPoint.y<minPoint.y) sqDistance+=(minPoint.y-uPoint.y)*(minPoint.y-uPoint.y);
        if (uPoint.y>maxPoint.y) sqDistance+=(uPoint.y-maxPoint.y)*(uPoint.y-maxPoint.y);
        
        //z-axis
        if (uPoint.z<minPoint.z) sqDistance+=(minPoint.z-uPoint.z)*(minPoint.z-uPoint.z);
        if (uPoint.z>maxPoint.z) sqDistance+=(uPoint.z-maxPoint.z)*(uPoint.z-maxPoint.z);
        
        
        return sqDistance;
    }
    
    bool U4DAABB::intersectionWithVolume(U4DSphere &uSphere){
        
        //Compute squared distance between sphere center and AABB
        
        float sqDistance=squareDistanceToPoint(uSphere.center);
        
        //Sphere and AABB intersect if the (squared) distance
        //between them is less than the (squared) sphere radius
        
        return sqDistance<=uSphere.radius*uSphere.radius;
        
    }
    
    bool U4DAABB::intersectionWithVolume(U4DSphere &uSphere, U4DPoint3n &uPoint){
        
        //Find point p on AABB closest to sphere center
        U4DPoint3n sphereCenter=uSphere.getCenter();
        
        closestPointOnAABBToPoint(sphereCenter, uPoint);
        
        //sphere and AABB intersect if the squared distance from sphere center to point uPoint is less than the squared
        //sphere radius
        
        U4DVector3n v=uPoint-sphereCenter;
        
        return v.dot(v)<=uSphere.radius*uSphere.radius;
        
    }
    
    void U4DAABB::setLongestAABBDimensionVector(U4DVector3n& uLongestAABBDimensionVector){
        longestAABBDimensionVector=uLongestAABBDimensionVector;
    }
    
    U4DVector3n U4DAABB::getLongestAABBDimensionVector(){
        return longestAABBDimensionVector;
    }
    
    bool U4DAABB::intersectionWithSegment(U4DSegment &uSegment){
        
        U4DPoint3n c=(minPoint+maxPoint)*0.5;  //box center point
        U4DVector3n e=maxPoint.toVector()-c.toVector();    //box halflengths extends
        U4DPoint3n m=(uSegment.pointA+uSegment.pointB)*0.5; //segment midpoint
        U4DVector3n d=uSegment.pointB.toVector()-m.toVector();  //segment halflength vector
        m=(m-c).toPoint();  //Translate box and segment to origin
        
        //try world coordinates axes as separating axis
        
        float adx=std::abs(d.x);
        if(std::abs(m.x)>e.x+adx) return false;
        
        float ady=std::abs(d.y);
        if(std::abs(m.y)>e.y+ady) return false;
        
        float adz=std::abs(d.z);
        if(std::abs(m.z)>e.z+adz) return false;
        
        //add in epsilon to counteract arithmetic errors when segment is near or parallel to a coordinate axis
        
        adx+=U4DEngine::zeroEpsilon;
        ady+=U4DEngine::zeroEpsilon;
        adz+=U4DEngine::zeroEpsilon;
        
        //try cross product of segment direction vector with coordinate axis
        if (std::abs(m.y*d.z-m.z*d.y)>(e.y*adz+e.z*ady)) return false;
        if (std::abs(m.z*d.x-m.x*d.z)>(e.x*adz+e.z*adx)) return false;
        if (std::abs(m.x*d.y-m.y*d.x)>(e.x*ady+e.y*adx)) return false;
        
        //no separating axis found; segment must be overlapping AABB
        return true;
    }
    
    
    bool U4DAABB::isPointInsideAABB(U4DPoint3n &uPoint){
        
        return (uPoint.x>=minPoint.x && uPoint.x<=maxPoint.x &&
                uPoint.y>=minPoint.y && uPoint.y<=maxPoint.y &&
                uPoint.z>=minPoint.z && uPoint.z<=maxPoint.z);
    }
    
    U4DVector3n U4DAABB::getHalfWidth(){
        
        return (getCenter()-getMaxPoint());
        
    }
    
    bool U4DAABB::intersectionWithTriangle(U4DTriangle &uTriangle){
        
        //declare the projection coordinates
        float p0,p1,p2;
        
        //get the AABB center and halfwidth
        U4DVector3n c=getCenter().toVector();
        
        float e0=getHalfWidth().x;
        float e1=getHalfWidth().y;
        float e2=getHalfWidth().z;
        
        //translate triangle as conceptually moving AABB to origin
        U4DVector3n v0=uTriangle.pointA.toVector();
        U4DVector3n v1=uTriangle.pointB.toVector();
        U4DVector3n v2=uTriangle.pointC.toVector();
        
        v0-=c;
        v1-=c;
        v2-=c;
        
        //compute edge vectors for triangle
        U4DVector3n f0=v1-v0;
        U4DVector3n f1=v2-v1;
        U4DVector3n f2=v0-v2;
        
        //get the normals
        U4DVector3n u0(1.0,0.0,0.0);
        U4DVector3n u1(0.0,1.0,0.0);
        U4DVector3n u2(0.0,0.0,1.0);
        
        //Category tests
        //1. Three face normals from the AABB
        //2. Once face from the triangle
        //3. Nine axis given by the cross products of combination of edges from both
        
        //The tests must be done in this order: 3-1-2
        
        //Category 3 test
        
        //a00=u0 x f0
        U4DVector3n a00=u0.cross(f0);
        U4DVector3n a01=u0.cross(f1);
        U4DVector3n a02=u0.cross(f2);
        
        U4DVector3n a10=u1.cross(f0);
        U4DVector3n a11=u1.cross(f1);
        U4DVector3n a12=u1.cross(f2);
        
        U4DVector3n a20=u2.cross(f0);
        U4DVector3n a21=u2.cross(f1);
        U4DVector3n a22=u2.cross(f2);
        
        U4DVector3n separatingAxis[9]={a00,a01,a02,a10,a11,a12,a20,a21,a22};
        
        //projection radius of box
        float projRadiusOfBox;
        float edgeProjectionMax, edgeProjectionMin;
        
        //test axis a00..a22
        
        for (int i=0; i<9; i++) {
            
            //get the projections of the triangle against the separating axis
            
            //p0=V0.a00
            p0=v0.dot(separatingAxis[i]);
            p1=v1.dot(separatingAxis[i]);
            p2=v2.dot(separatingAxis[i]);
            
            
            //projection radius of box
            projRadiusOfBox=std::fabs(u0.dot(separatingAxis[i]))*e0+std::fabs(u1.dot(separatingAxis[i]))*e1+std::fabs(u2.dot(separatingAxis[i]))*e2;
            
            edgeProjectionMax=std::max(p0, std::max(p1,p2));
            edgeProjectionMin=std::min(p0, std::min(p1,p2));
            
            if(std::max(edgeProjectionMin,-edgeProjectionMax)>projRadiusOfBox){
                
                return false; //axis is a separating axis
                
            }
            
        }
        
        //category 1 test.
        //Test the tree axes corresponding to the face normals of AABB box
        //exit if...
        //..[-e0,e0] and [min(v0.x,v1.x,v2.x),max(v0.x,v1.x,v2.x)] do not overlap
        if (std::max(v0.x,std::max(v1.x,v2.x))<-e0 || std::min(v0.x,std::min(v1.x,v2.x))>e0) {
            return false;
        }
        
        //..[-e1,e1] and [min(v0.y,v1.y,v2.y),max(v0.y,v1.y,v2.y)] do not overlap
        if (std::max(v0.y,std::max(v1.y,v2.y))<-e1 || std::min(v0.y,std::min(v1.y,v2.y))>e1) {
            return false;
        }
        
        //..[-e2,e2] and [min(v0.z,v1.z,v2.z),max(v0.z,v1.z,v2.z)] do not overlap
        if (std::max(v0.z,std::max(v1.z,v2.z))<-e2 || std::min(v0.z,std::min(v1.z,v2.z))>e2) {
            return false;
        }
        
        //category 2 test
        //test separating axis corresponding to triangle face normal
        
        U4DVector3n planeNormal=f0.cross(f1);
        float planeDistance=planeNormal.dot(v0);
        
        U4DPlane plane(planeNormal,planeDistance);
        
        //translate the box to the center
        U4DPoint3n centeredAABBMinPoint=(getMinPoint().toVector()-c).toPoint();
        U4DPoint3n centeredAABBMaxPoint=(getMaxPoint().toVector()-c).toPoint();
        
        U4DAABB centeredAABB(centeredAABBMinPoint,centeredAABBMaxPoint);
        
        return centeredAABB.intersectionWithPlane(plane);
        
    }
    
    bool U4DAABB::intersectionWithPlane(U4DPlane &uPlane){
        
        //Compute AABB Center
        U4DPoint3n c=getCenter();
        
        //Compute positive halfwidths
        U4DPoint3n e=getHalfWidth().toPoint();
        
        //Compute the projection interval of radius of AABB onto plane
        float r=e.x*std::abs(uPlane.n.x)+e.y*std::abs(uPlane.n.y)+e.z*std::abs(uPlane.n.z);
        
        //Compute distance of box center from plane
        float s=uPlane.n.dot(c.toVector())-uPlane.d;
        
        //intersection occurs when distance s falls within [-r,r] interval
        return std::abs(s)<=r;
        
    }
    
    void U4DAABB::closestPointOnAABBToPoint(U4DPoint3n &uPoint, U4DPoint3n &uClosestPoint){
        
        //For each coordinate axis, if the point coordinate value is outside box, clamp it to the box, else
        //keep it as is
        
        float p[3]={uPoint.x,uPoint.y,uPoint.z};
        float bmin[3]={minPoint.x,minPoint.y,minPoint.z};
        float bmax[3]={maxPoint.x,maxPoint.y,maxPoint.z};
        float q[3];
        
        for(int i=0; i<3; i++) {
            
            float v=p[i];
            
            if (v<bmin[i]) v=bmin[i]; //v=max(v,bmin[i])
            if (v>bmax[i]) v=bmax[i]; //v=min(v,bmax[i])
            
            q[i]=v;
            
        }
        
        uClosestPoint.x=q[0];
        uClosestPoint.y=q[1];
        uClosestPoint.z=q[2];
        
    }
    
    bool U4DAABB::aabbPlanePointLies(U4DPoint3n &uPoint, U4DPlane &uPlane){
        
        if (isPointInsideAABB(uPoint)) {
            
            //set the normal vectors for the plane
            U4DVector3n n[6]={U4DVector3n(1.0,0.0,0.0),U4DVector3n(0.0,1.0,0.0),U4DVector3n(0.0,0.0,1.0),U4DVector3n(-1.0,0.0,0.0),U4DVector3n(0.0,-1.0,0.0),U4DVector3n(0.0,0.0,-1.0)};
            
            //declare the planes making up the aabb faces
            U4DPlane plane0(n[0],maxPoint);
            U4DPlane plane1(n[1],maxPoint);
            U4DPlane plane2(n[2],maxPoint);
            U4DPlane plane3(n[3],minPoint);
            U4DPlane plane4(n[4],minPoint);
            U4DPlane plane5(n[5],minPoint);
            
            U4DPlane planeArray[6]={plane0,plane1,plane2,plane3,plane4,plane5};
            
            //find the closest plane to point
            float minDistanceToPlane=FLT_MAX;
            int closestPlaneIndex=0;
            
            for (int i=0; i<6; i++) {
                
                float closestDistanceToPlane=fabs(planeArray[i].magnitudeOfPointToPlane(uPoint));
                
                if (closestDistanceToPlane<=minDistanceToPlane) {
                    
                    minDistanceToPlane=closestDistanceToPlane;
                    closestPlaneIndex=i;
                    
                }
                
            }
            
            uPlane=planeArray[closestPlaneIndex];
            
            return true;
        }
        
        //the point does not lie within or on the AABB
        return false;
    }
    
}
