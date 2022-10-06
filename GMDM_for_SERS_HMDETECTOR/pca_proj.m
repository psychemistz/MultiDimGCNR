function [Y_proj, lambda] = pca_proj(X,Y,components)
%%
% X -> [Samples X attributes]
X = X - repmat(mean(X),size(X,1),1);
Y = Y - repmat(mean(Y),size(Y,1),1);
[V,D] = eig(X'*X);
[lambda,B] = sort(diag(D),'descend');
Y_proj = Y*V(:,B(1:components));
lambda = lambda(1:components);
end