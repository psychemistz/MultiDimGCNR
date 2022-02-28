read_orl_dset <- function(){
  require(dplyr)
  require(jpeg)
  path = "path_to_ORL_datset" ## Modify this line to the download folder of ORL dataset.
  flist = list.files(path, full.names = T)
  fname = list.files(path, full.names = F)
  fname = gsub(".jpg", "", fname)
  fname = do.call(rbind, strsplit(fname, "_"))
  colnames(fname) = c("Sample_ID", "Person_ID")
  fname = as.data.frame(fname)
  flist = data.frame(fname, file = flist)
  flist = flist[,c(2,1,3)]
  flist = flist %>% mutate(Person_ID = as.numeric(Person_ID),
                           Sample_ID = as.numeric(Sample_ID)) %>% arrange(Person_ID, Sample_ID)

  dset = lapply(flist$file, readJPEG)
  dset = lapply(dset, as.vector)

  dset_update = list()
  for(i in 1:41){
    start = (i-1) * 10 + 1
    end = (i-1) * 10 + 10
    tmp_dset = do.call(rbind, dset[start:end])
    dset_update[[i]] = as.matrix(tmp_dset)
  }

  train_label = do.call(c, lapply(1:41, function(i) rep(i, 5)))
  test_label = do.call(c, lapply(1:41, function(i) rep(i, 5)))
  train_image = lapply(1:41, function(i) dset_update[[i]][1:5,])
  test_image =  lapply(1:41, function(i) dset_update[[i]][6:10,])
  return(list(train=train_image, test=test_image, train_label=train_label, test_label=test_label))
}

dset = read_orl_dset()
do.call(rbind, lapply(dset$train, dim))
do.call(rbind, lapply(dset$test, dim))
length(dset$train_label)
length(dset$test_label)

