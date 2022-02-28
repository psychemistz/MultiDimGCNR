## Figure 5
epoch_500 = R.matlab::readMat("./0processed_dsets/Weather_style_transfer/epoch_500.mat")
epoch_1000 = R.matlab::readMat("./0processed_dsets/Weather_style_transfer/epoch_1000.mat")
epoch_1500 = R.matlab::readMat("./0processed_dsets/Weather_style_transfer/epoch_1500.mat")
epoch_2000 = R.matlab::readMat("./0processed_dsets/Weather_style_transfer/epoch_2000.mat")
epoch_2500 = R.matlab::readMat("./0processed_dsets/Weather_style_transfer/epoch_2500.mat")
epoch_3000 = R.matlab::readMat("./0processed_dsets/Weather_style_transfer/epoch_3000.mat")
epoch_3500 = R.matlab::readMat("./0processed_dsets/Weather_style_transfer/epoch_3500.mat")
epoch_4000 = R.matlab::readMat("./0processed_dsets/Weather_style_transfer/epoch_4000.mat")

OVL_mat = rbind(data.frame(epoch_500$res2, epoch=500),
                data.frame(epoch_1000$res2, epoch=1000),
                data.frame(epoch_1500$res2, epoch=1500),
                data.frame(epoch_2000$res2, epoch=2000),
                data.frame(epoch_2500$res2, epoch=2500),
                data.frame(epoch_3000$res2, epoch=3000),
                data.frame(epoch_3500$res2, epoch=3500),
                data.frame(epoch_4000$res2, epoch=4000))

colnames(OVL_mat) = c("IT", "OT", "IO", "epoch")
OVL_mat %>% tidyr::gather(comparison, OVL, -epoch) %>% mutate(epoch = as.numeric(epoch)) %>%
  ggplot(aes(x=epoch, y=OVL, col=comparison)) + geom_point() + geom_line() + theme_bw()


## OVL Statistics 
OVL_mat %>% group_by(epoch) %>% summarise_all(mean)
OVL_mat %>% group_by(epoch) %>% summarise_all(sd)

