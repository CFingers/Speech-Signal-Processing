function out = nan_to_num(vector)
% converts NaN to 0 and inf to +/-1.79769313e308


        fake_inf = 1.79769313e308;
        neg_inf = -1.79769313e308;
        vector(isnan(vector)) = 0;
        vector(find(vector == inf)) = fake_inf;
        vector(find(vector == -inf)) = neg_inf;
        out = vector;
end
            