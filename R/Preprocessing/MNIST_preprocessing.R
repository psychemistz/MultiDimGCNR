read_mnist_dset <- function(){

  require(dslabs)
  require(overlapping)

  mnist_dset = dslabs::read_mnist()
  
  train_0 = which(mnist_dset$train$labels == 0)
  train_1 = which(mnist_dset$train$labels == 1)
  train_2 = which(mnist_dset$train$labels == 2)
  train_3 = which(mnist_dset$train$labels == 3)
  train_4 = which(mnist_dset$train$labels == 4)
  train_5 = which(mnist_dset$train$labels == 5)
  train_6 = which(mnist_dset$train$labels == 6)
  train_7 = which(mnist_dset$train$labels == 7)
  train_8 = which(mnist_dset$train$labels == 8)
  train_9 = which(mnist_dset$train$labels == 9)
  
  train_0_image = mnist_dset$train$images[train_0,]
  train_1_image = mnist_dset$train$images[train_1,]
  train_2_image = mnist_dset$train$images[train_2,]
  train_3_image = mnist_dset$train$images[train_3,]
  train_4_image = mnist_dset$train$images[train_4,]
  train_5_image = mnist_dset$train$images[train_5,]
  train_6_image = mnist_dset$train$images[train_6,]
  train_7_image = mnist_dset$train$images[train_7,]
  train_8_image = mnist_dset$train$images[train_8,]
  train_9_image = mnist_dset$train$images[train_9,]
  
  test_0 = which(mnist_dset$test$labels == 0)
  test_1 = which(mnist_dset$test$labels == 1)
  test_2 = which(mnist_dset$test$labels == 2)
  test_3 = which(mnist_dset$test$labels == 3)
  test_4 = which(mnist_dset$test$labels == 4)
  test_5 = which(mnist_dset$test$labels == 5)
  test_6 = which(mnist_dset$test$labels == 6)
  test_7 = which(mnist_dset$test$labels == 7)
  test_8 = which(mnist_dset$test$labels == 8)
  test_9 = which(mnist_dset$test$labels == 9)
  
  test_0_image = mnist_dset$test$images[test_0,]
  test_1_image = mnist_dset$test$images[test_1,]
  test_2_image = mnist_dset$test$images[test_2,]
  test_3_image = mnist_dset$test$images[test_3,]
  test_4_image = mnist_dset$test$images[test_4,]
  test_5_image = mnist_dset$test$images[test_5,]
  test_6_image = mnist_dset$test$images[test_6,]
  test_7_image = mnist_dset$test$images[test_7,]
  test_8_image = mnist_dset$test$images[test_8,]
  test_9_image = mnist_dset$test$images[test_9,]
  
  
  train_list = list(train_0_image, train_1_image, train_2_image, train_3_image, train_4_image,
                    train_5_image, train_6_image, train_7_image, train_8_image, train_9_image)
  test_list = list(test_0_image, test_1_image, test_2_image, test_3_image, test_4_image,
                   test_5_image, test_6_image, test_7_image, test_8_image, test_9_image)
  
  train_label = c(rep(0, dim(train_0_image)[1]), rep(1, dim(train_1_image)[1]), rep(2, dim(train_2_image)[1]),
                  rep(3, dim(train_3_image)[1]), rep(4, dim(train_4_image)[1]), rep(5, dim(train_5_image)[1]),
                  rep(6, dim(train_6_image)[1]), rep(7, dim(train_7_image)[1]), rep(8, dim(train_8_image)[1]),
                  rep(9, dim(train_9_image)[1]))
  
  test_label = c(rep(0, dim(test_0_image)[1]), rep(1, dim(test_1_image)[1]), rep(2, dim(test_2_image)[1]),
                  rep(3, dim(test_3_image)[1]), rep(4, dim(test_4_image)[1]), rep(5, dim(test_5_image)[1]),
                  rep(6, dim(test_6_image)[1]), rep(7, dim(test_7_image)[1]), rep(8, dim(test_8_image)[1]),
                  rep(9, dim(test_9_image)[1]))
  
  return(list(train=train_list, test=test_list, train_label=train_label, test_label=test_label))
}


mnist_dset = read_mnist_dset()

