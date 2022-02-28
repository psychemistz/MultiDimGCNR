library(R.matlab)
tcb = readMat("./0processed_dsets/Weather_denoising/ChannelWise_GMDM_scores_TCB_Weather_noise_01_trial1.mat")
unet = readMat("./0processed_dsets/Weather_denoising/ChannelWise_GMDM_scores_UNET_Weather_noise_01_trial1.mat")
colnames(tcb$SF) = c("RED", "GREEN", "BLUE")
colnames(tcb$SN) = c("RED", "GREEN", "BLUE")

tcb_sf = data.frame(tcb$SF)
tcb_sf$method = "TC-MRDBNet"
tcb_sn = data.frame(tcb$SN)
tcb_sn$method = "baseline"


colnames(unet$SF) = c("RED", "GREEN", "BLUE")
colnames(unet$SN) = c("RED", "GREEN", "BLUE")
unet_sf = data.frame(unet$SF)
unet_sf$method = "UNET"
unet_sn = data.frame(unet$SN)
unet_sn$method = "baseline"

head(tcb_sf)
head(unet_sf)
sf_all = rbind(tcb_sf, unet_sf)
sn_all = rbind(tcb_sn, unet_sn)

sf_all %>% group_by(method) %>% summarise_all(list(mean))

res_mat = sf_all %>% as.data.frame() %>% tidyr::gather(channel, value, -method) %>% mutate(comp="Clean vs Filtered") %>%
  bind_rows(sn_all %>% as.data.frame() %>% tidyr::gather(channel, value, -method) %>% mutate(comp="Clean vs Noisy")) %>%
  mutate(comp = factor(comp), channel = factor(channel, levels=c("RED", "GREEN", "BLUE")), 
         method = factor(method, levels=c("baseline", "UNET", "TC-MRDBNet")))

p = res_mat %>% ggplot(aes(x=channel, y=value, col=interaction(comp, method, channel))) + geom_boxplot() + 
  geom_point(aes(shape = method), size = 1.5, position = position_jitterdodge()) + theme_bw()

p + scale_color_manual(values=c("red", "red", "red", 
                                "darkgreen", "darkgreen", "darkgreen",
                                "blue", "blue", "blue")) + 
  scale_fill_manual(values=c("red", "red", "red", 
                             "darkgreen", "darkgreen", "darkgreen", 
                             "blue", "blue", "blue")) 
