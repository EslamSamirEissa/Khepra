function intersect=checkIntersection(L1_p1,L1_p2,L2_p1,L2_p2)


dir1 = getDirection(L1_p1, L1_p2, L2_p1);
dir2 = getDirection(L1_p1, L1_p2, L2_p2);
dir3 = getDirection(L2_p1, L2_p2, L1_p1);
dir4 = getDirection(L2_p1, L2_p2, L1_p2);


if (dir1~= dir2) && (dir3~= dir4)
    intersect= true;
    return


elseif (dir1 ==0) && collinear([L1_p1;L1_p2;L2_p1])
    intersect= true;
    return


elseif (dir2 ==0) && collinear([L1_p1;L1_p2;L2_p2])
    intersect= true;
    return


elseif (dir3 ==0) && collinear([L2_p1;L2_p2;L1_p1])
    intersect= true;
    return
    
elseif (dir4 ==0) && collinear([L2_p1;L2_p2;L2_p2])
    intersect= true;
    return
    
else
    intersect= false;
    return
end



end