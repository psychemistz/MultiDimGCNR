function [Y_proj, A] = pca_proj(X, Y, components)
%%
% X -> [Samples X attributes]
X = X - repmat(mean(X),size(X,1),1);
[V,D] = eig(X'*X);
[A,B] = sort(diag(D),'descend');
Y_proj = X*V(:,B(1:components));
A = A(1:components);
end