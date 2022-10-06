function [G_score] = findGMDM(neg_data, pos_data,components)


combined_data = [neg_data;pos_data];
combined_data = combined_data./max(abs(combined_data(:)));

[neg_data, lambda] = pca_proj(combined_data,neg_data,components);
[pos_data, lambda] = pca_proj(combined_data,pos_data,components);
G_score = 0;
for i = 1:components
    temp =  OVL(neg_data(:,i)',pos_data(:,i)');
    G_score = G_score + lambda(i)*temp;
end
G_score = G_score./sum(lambda);