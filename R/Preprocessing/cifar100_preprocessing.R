## Using Keras
library(keras)
cifar100_fine_dset = dataset_cifar10()
cifar100_train_image = lapply(1:50000, function(i) as.vector(cifar100_fine_dset$train$x[i, , ,]))
cifar100_test_image = lapply(1:10000, function(i) as.vector(cifar100_fine_dset$test$x[i, , ,]))
cifar100_test_label = as.vector(cifar100_fine_dset$test$y)
cifar100_train_label = as.vector(cifar100_fine_dset$train$y)

train_image_sorted = cifar100_train_image[order(cifar100_train_label)]
test_image_sorted = cifar100_test_image[order(cifar100_test_label)]
train_label_sorted = sort(cifar100_train_label)
test_label_sorted = sort(cifar100_test_label)

table(train_label_sorted)
table(test_label_sorted)  # 1000

n_classes = length(table(train_label_sorted))
class_id = names(table(train_label_sorted))

train_list = lapply(1:n_classes, function(i) do.call(rbind, train_image_sorted[train_label_sorted == class_id[i]]))
test_list = lapply(1:n_classes, function(i) do.call(rbind, test_image_sorted[test_label_sorted == class_id[i]]))

do.call(rbind, lapply(train_list, dim))
do.call(rbind, lapply(test_list, dim))

savepath = "save_path" ## modify savepath
saveRDS(list(train=train_list, test=test_list, train_lab = train_label_sorted, test_lab = test_label_sorted),
        paste0(savepath, "cifar100.RDS"))













