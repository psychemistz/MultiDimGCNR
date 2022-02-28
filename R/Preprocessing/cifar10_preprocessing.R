# Read binary file and convert to integer vectors
# [Necessary because reading directly as integer() 
# reads first bit as signed otherwise]
#
# File format is 10000 records following the pattern:
# [label x 1][red x 1024][green x 1024][blue x 1024]
# NOT broken into rows, so need to be careful with "size" and "n"
#
# (See http://www.cs.toronto.edu/~kriz/cifar.html)

## Train
path = "path-to-CIFAR10 dataset" #Modify this line to the download folder of CIFAR10 data set.
labels <- read.table(paste0(path, "batches.meta.txt"))
images.rgb <- list()
images.lab <- list()
num.images = 10000 # Set to 10000 to retrieve all images per file to memory

# Cycle through all 5 binary files
for (f in 1:5) {
  to.read <- file(paste(path, "data_batch_", f, ".bin", sep=""), "rb")
  for(i in 1:num.images) {
    l <- readBin(to.read, integer(), size=1, n=1, endian="big")
    r <- as.integer(readBin(to.read, raw(), size=1, n=1024, endian="big"))
    g <- as.integer(readBin(to.read, raw(), size=1, n=1024, endian="big"))
    b <- as.integer(readBin(to.read, raw(), size=1, n=1024, endian="big"))
    index <- num.images * (f-1) + i
    images.rgb[[index]] = data.frame(r, g, b)
    images.lab[[index]] = l+1
  }
  close(to.read)
  remove(l,r,g,b,f,i,index, to.read)
}

train_images = lapply(1:length(images.rgb), function(i) as.vector(unlist(images.rgb[[i]], use.names = F)))
train_label = images.lab
train_label = do.call(c, train_label)

# Test
to.read <- file(paste(path, "test_batch.bin", sep=""), "rb")
num.images = 10000
images.rgb <- list()
images.lab <- list()
  for(i in 1:num.images) {
    l <- readBin(to.read, integer(), size=1, n=1, endian="big")
    r <- as.integer(readBin(to.read, raw(), size=1, n=1024, endian="big"))
    g <- as.integer(readBin(to.read, raw(), size=1, n=1024, endian="big"))
    b <- as.integer(readBin(to.read, raw(), size=1, n=1024, endian="big"))
    index <- i
    images.rgb[[index]] = data.frame(r, g, b)
    images.lab[[index]] = l+1
  }
close(to.read)
remove(l,r,g,b,i,index, to.read)

test_images = lapply(1:length(images.rgb), function(i) as.vector(unlist(images.rgb[[i]], use.names = F)))
test_label = images.lab
test_label = do.call(c, test_label)

length(test_images)
length(test_label)

train_image_sorted = train_images[order(train_label)]
test_image_sorted = test_images[order(test_label)]
train_label_sorted = sort(train_label)
test_label_sorted = sort(test_label)

table(train_label_sorted) # 5000
table(test_label_sorted)  # 1000

train_list = list()
train_list[[1]] = do.call(rbind, train_image_sorted[1:5000])
train_list[[2]] = do.call(rbind, train_image_sorted[5000+1:2*5000])
train_list[[3]] = do.call(rbind, train_image_sorted[5000*2+1:3*5000])
train_list[[4]] = do.call(rbind, train_image_sorted[5000*3+1:4*5000])

train_list = lapply(1:10, function(i) do.call(rbind, train_image_sorted[(5000*(i-1)+1):(i*5000)]))
test_list = lapply(1:10, function(i) do.call(rbind, test_image_sorted[(1000*(i-1)+1):(i*1000)]))

do.call(rbind, lapply(train_list, dim))
do.call(rbind, lapply(test_list, dim))


cifar10_dset = list(train=train_list, test=test_list, train_lab = train_label_sorted, test_lab = test_label_sorted)

saveRDS(cifar10_dset, paste0(path, "cifar10.RDS"))