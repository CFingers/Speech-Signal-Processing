function c = vqlbg(d,k)
% d = features; k = M for comparison from stanford

% Set up our centroid values.
eps = 0.01;
c = mean(d,2);
distortion = 1;
nCentroid = 1;

%  Calculate the general area around the centroid with previous values.
while nCentroid < k
    new_c = zeros(size(c,1),nCentroid*2);
    if nCentroid == 1
        new_c(:,1) = c*(1+eps);
        new_c(:,2) = c*(1-eps);

    else
        for i = 1:nCentroid
            new_c(:,(2*i)-1) = c(:,i)*(1+eps);
            new_c(:,2*i) = c(:,i)*(1-eps);
        end
    end
    
    c = new_c;
    
    [r col] = size(c);
    nCentroid = col;
    z = disteu(d,c);

    %  Calculate the centroid value and use nan_to_num to solve infinite
    %  values.  Euclidean distance is found for the centroid in this group
    %  of code with the function disteu.
    while abs(distortion) > eps
        prev_distance = mean(z);
        [nearest_c, ind] = min(z,[],2);

        for i = 1:nCentroid
             c(:,i) = mean(d(:,find(ind == i)),2);   
        end
        
        c = nan_to_num(c);
        
        z = disteu(d,c);
        distortion = (prev_distance - mean(z))./prev_distance;
    end
end
end