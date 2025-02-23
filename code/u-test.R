
#  028-fr_cz_flw__n_175__m_5.md
model_A_accuracy <- c(
    0.8986672, 0.9071266, 0.9016988, 0.8908271, 0.9017584, 0.9043544, 0.9002144, 0.9126787, 0.9028094, 0.9039646
)

model_A_f1 <- c(
    0.9015800, 0.9099596, 0.9052438, 0.8979293, 0.9070524, 0.9080607, 0.9051501, 0.9193094, 0.9082766, 0.9091240
)

# 021-add_follow_rate__remove_cz_flw.md
model_B_accuracy <- c(
    0.9091961, 0.9110544, 0.9001724, 0.8928641, 0.9008170, 0.9053153, 0.9002095, 0.9044923, 0.9035258, 0.9015922
)

model_B_f1 <- c(
    0.9125023, 0.9157523, 0.9045962, 0.9006166, 0.9061826, 0.9104343, 0.9045537, 0.9083001, 0.9090577, 0.9057505
)

# Test if the accuracy of model A is significantly different from model B
print("Test if the accuracy of models A and B are significantly different")
wilcox.test(model_A_accuracy, model_B_accuracy, alternative = "two.sided")

# Test if the f1 of model A is significantly different from model B
print("Test if the f1 of models A and B are significantly different")
wilcox.test(model_A_f1, model_B_f1, alternative = "two.sided")

## Make box plots
boxplot(model_A_accuracy, model_B_accuracy, names = c("Model A (28)", "Model B (21)"), ylab = "Accuracy", main = "Accuracy comparison between Model A and Model B")

boxplot(model_A_f1, model_B_f1, names = c("Model A (28)", "Model B (21)"), ylab = "F1", main = "F1 comparison between Model A and Model B")


