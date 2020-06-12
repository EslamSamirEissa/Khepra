function model= normalizeScale(model,factor)

X_maximum=max(model.vertices(:,1));

newfactor=X_maximum/factor;

model.vertices=model.vertices/newfactor;

end